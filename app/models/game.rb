class Game < ApplicationRecord
  has_many :game_moves, dependent: :destroy
  has_many :moves, through: :game_moves

  def display_name
    "#{white} - #{black} | #{result}"
  end
end
