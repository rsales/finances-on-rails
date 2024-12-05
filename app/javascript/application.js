// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chart.js"

document.addEventListener("turbo:load", () => {
  const data = JSON.parse(document.getElementById("chart-data").textContent);

  console.log(data);

  const labels = [
    "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", 
    "Jul", "Ago", "Set", "Out", "Nov", "Dez"
  ];

  window.chartColors = {
    red: "rgba(255, 99, 132, 1)",
    orange: "rgba(255, 159, 64, 1)",
    yellow: "rgba(255, 205, 86, 1)",
    green: "rgba(75, 192, 192, 1)",
    blue: "rgba(54, 162, 235, 1)",
    purple: "rgba(153, 102, 255, 1)",
    grey: "rgba(231, 233, 237, 1)"
  };

  var barChartData = {
    labels: labels,
    datasets: [
      {
        label: "Receita",
        backgroundColor: window.chartColors.green,
        borderColor: window.chartColors.green,
        yAxisID: "y-axis-2",
        data: data.gastos_fixos,
        type: "line",
        fill: false,
      },
      {
        label: "Gastos Fixos",
        backgroundColor: window.chartColors.red,
        yAxisID: "y-axis-1",
        data: data.receitas
      },
      {
        label: "Gastos Variáveis",
        backgroundColor: window.chartColors.yellow,
        yAxisID: "y-axis-1",
        data: data.gastos_variaveis
      },
      {
        label: "Investimentos",
        backgroundColor: window.chartColors.blue,
        yAxisID: "y-axis-1",
        data: data.investimentos
      },
    ]
  };

  console.log(barChartData);

  window.onload = function () {
    var ctx = document.getElementById("consolidatedChart").getContext("2d");
    window.myBar = new Chart(ctx, {
      type: "bar",
      data: barChartData,
      options: {
        responsive: true,
        title: {
          display: false,
          text: "Chart.js Bar Chart - Multi Axis"
        },
        tooltips: {
          mode: "index",
          intersect: true
        },
        scales: {
          xAxes: [
            {
              stacked: true,
              barThickness: 40,
            }
          ],
          yAxes: [
            {
              type: "linear",
              stacked: true,
              display: true,
              position: "left",
              id: "y-axis-1",
              ticks: {
                beginAtZero: true,
                suggestedMin: 0,
                suggestedMax: 10,
                min: 0
              }
            },
            {
              type: "linear",
              display: false,
              id: "y-axis-2",
              ticks: {
                beginAtZero: true,
                suggestedMin: 0,
                suggestedMax: 10,
                min: 0
              }
            }
          ]
        }
      }
    });
  };
});
