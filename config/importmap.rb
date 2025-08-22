# Pin npm packages by running ./bin/importmap

pin "application"
pin "alpinejs" # @3.14.9
pin_all_from "app/javascript/alpine", under: "alpine", preload: false
pin_all_from "app/javascript/climb_logs", under: "climb_logs", preload: false
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels", preload: true
pin "@tailwindplus/elements", to: "@tailwindplus--elements.js" # @1.0.9
