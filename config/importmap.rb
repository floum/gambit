# Pin npm packages by running ./bin/importmap

pin "application"
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "chessground" # @9.1.1
pin "chess.js" # @1.0.0
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
