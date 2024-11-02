// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"

import 'chessground';
import { Chessground } from 'chessground'

let board = document.getElementById('chessboard')

Chessground(board, {})
