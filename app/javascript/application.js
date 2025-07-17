// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"
import Rails from "@rails/ujs"
Rails.start()

function parse() {
  var pgn = document.getElementById('game_training_game_pgn')
  console.log(pgn)
}
