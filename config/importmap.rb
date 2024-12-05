# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "vue", to: "https://unpkg.com/vue@3/dist/vue.esm-browser.js" # @3.5.13
pin "chart.js", to: "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.bundle.min.js" # @2.4.0
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
