// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chart.js"

//////////////////////////////
// Consolidated Chart
//////////////////////////////

document.addEventListener("turbo:load", () => {
  const spinner = document.getElementById("loading-spinner");
  const chartElement = document.getElementById("consolidatedChart");

  if (chartElement) {
    const data = JSON.parse(document.getElementById("chart-data").textContent);

    const labels = [
      "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", 
      "Jul", "Ago", "Set", "Out", "Nov", "Dez"
    ];

    const chartColors = {
      red: "rgba(255, 99, 132, 1)",
      orange: "rgba(255, 159, 64, 1)",
      yellow: "rgba(255, 205, 86, 1)",
      green: "rgba(75, 192, 192, 1)",
      blue: "rgba(54, 162, 235, 1)",
      purple: "rgba(153, 102, 255, 1)",
      grey: "rgba(231, 233, 237, 1)"
    };

    const barChartData = {
      labels: labels,
      datasets: [
        {
          label: "Receita",
          backgroundColor: chartColors.green,
          borderColor: chartColors.green,
          data: data.receitas,
          type: "line",
          borderWidth: 2,
          tension: 0.4,
          yAxisID: "y2",
          fill: false
        },
        {
          label: "Gastos Fixos",
          backgroundColor: chartColors.red,
          data: data.gastos_fixos,
          barThickness: 40,
          yAxisID: "y"
        },
        {
          label: "Gastos Variáveis",
          backgroundColor: chartColors.yellow,
          data: data.gastos_variaveis,
          barThickness: 40,
          yAxisID: "y"
        },
        {
          label: "Investimentos",
          backgroundColor: chartColors.blue,
          data: data.investimentos,
          barThickness: 40,
          yAxisID: "y"
        }
      ]
    };

    setTimeout(() => {
      const ctx = chartElement.getContext("2d");

      window.myBar = new Chart(ctx, {
        type: "bar",
        data: barChartData,
        options: {
          responsive: true,
          plugins: {
            tooltip: {
              mode: "index",
              intersect: true
            },
            legend: {
              display: true,
              position: "bottom",
              align: "start",
              labels: {
                usePointStyle: "circle",
              },
            },
            title: {
              display: false,
              text: "Chart.js Bar Chart - Multi Axis"
            }
          },
          scales: {
            x: {
              stacked: true,
              title: {
                display: false,
                text: "Meses"
              }
            },
            y: {
              type: "linear",
              stacked: true,
              position: "left",
              beginAtZero: true,
              max: 6000,
              ticks: {
                stepSize: 2,
              }
            },
            y2: {
              type: "linear",
              position: "right",
              beginAtZero: true,
              max: 6000,
              grid: {
                drawOnChartArea: false // Remove as linhas do grid no lado direito
              },
              ticks: {
                display: false,
                stepSize: 2,
              }
            }
          }
        }
      });

      spinner.style.display = "none";
      chartElement.style.display = "block";
    }, 950);
  }
});

//////////////////////////////
// Open and Close Modal
//////////////////////////////

document.addEventListener("turbo:frame-load", (event) => {
  const modal = document.getElementById("modal");
  if (event.target.id === "modal-frame") {
    modal.classList.remove("hidden");
    setTimeout(() => {
      modal.classList.remove("translate-x-full");
    }, 10); // Pequeno atraso para garantir que a classe hidden seja removida antes da transição
  }
});

document.addEventListener("click", (event) => {
  if (event.target.matches(".modal") || event.target.closest(".modal-close")) {
    const modal = document.getElementById("modal");
    modal.classList.add("translate-x-full");
    setTimeout(() => {
      modal.classList.add("hidden");
    }, 300); // Duração da transição
  }
});

//////////////////////////////
// Open delete confirmation modal
//////////////////////////////

document.addEventListener("turbo:load", () => {
  const deleteButtons = document.querySelectorAll(".delete-transaction");
  const modal = document.getElementById("delete-confirmation-modal");
  const deleteFutureOnlyButton = document.getElementById("delete-future-only");
  const deleteAllButton = document.getElementById("delete-all");
  const cancelDeleteButton = document.getElementById("cancel-delete");

  let transactionId = null;
  let familyGroupId = null;

  deleteButtons.forEach(button => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      transactionId = button.dataset.transactionId;
      familyGroupId = button.dataset.familyGroupId;
      modal.classList.remove("hidden");
    });
  });

  deleteFutureOnlyButton.addEventListener("click", () => {
    if (transactionId && familyGroupId) {
      fetch(`/finances/${familyGroupId}/transactions/${transactionId}/destroy_future`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(() => {
        window.location.reload();
      });
    }
  });

  deleteAllButton.addEventListener("click", () => {
    if (transactionId && familyGroupId) {
      fetch(`/finances/${familyGroupId}/transactions/${transactionId}`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(() => {
        window.location.reload();
      });
    }
  });

  cancelDeleteButton.addEventListener("click", () => {
    modal.classList.add("hidden");
  });
});


//////////////////////////////
// Open dropdown Add new transaction
//////////////////////////////

document.addEventListener("turbo:load", function () {
  const button = document.querySelector('#button-add-transaction');
  const dropdown = document.querySelector('#dropdown-transactions');
  const bgDropdown = document.querySelector('#bg-dropdown');

  button.addEventListener('click', function () {
    if (dropdown.classList.contains('hidden')) {
      dropdown.classList.remove('hidden');
      dropdown.classList.add('transition', 'ease-out', 'duration-100', 'transform', 'opacity-100', 'scale-100');
      dropdown.classList.remove('opacity-0', 'scale-95');
      // bgDropdown.classList.remove('hidden');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-100', 'transform', 'opacity-60');
      // bgDropdown.classList.remove('opacity-0');
    } else {
      dropdown.classList.add('transition', 'ease-in', 'duration-75', 'transform', 'opacity-0', 'scale-95');
      dropdown.classList.remove('opacity-100', 'scale-100');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-75', 'transform', 'opacity-0');
      // bgDropdown.classList.remove('opacity-60');
      setTimeout(() => {
        dropdown.classList.add('hidden');
        // bgDropdown.classList.add('hidden');
      }, 75);
    }
  });

  document.addEventListener('click', function (event) {
    if (!button.contains(event.target) && !dropdown.contains(event.target)) {
      dropdown.classList.add('transition', 'ease-in', 'duration-75', 'transform', 'opacity-0', 'scale-95');
      dropdown.classList.remove('opacity-100', 'scale-100');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-75', 'transform', 'opacity-0');
      // bgDropdown.classList.remove('opacity-60');
      setTimeout(() => {
        dropdown.classList.add('hidden');
        // bgDropdown.classList.add('hidden');
      }, 75);
    }
  });
});