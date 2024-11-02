# Pin npm packages by running ./bin/importmap

pin "application"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "chessground" # @9.1.1
