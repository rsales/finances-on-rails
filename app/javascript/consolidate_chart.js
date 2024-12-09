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