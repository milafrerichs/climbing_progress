# Pin npm packages by running ./bin/importmap

pin "application"
pin_all_from "app/javascript/alpine", under: "alpine", preload: false
pin_all_from "app/javascript/climb_logs", under: "climb_logs", preload: false
pin "alpinejs" # @3.14.9
