class Game < ApplicationRecord
  has_many :game_moves
  has_many :moves, through: :game_moves
end
