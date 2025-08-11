class GameReview < ApplicationRecord
  belongs_to :game

  delegate :moves, to: :game, prefix: false

  def game_name
    game.display_name
  end

  def color
    game.review_as_white ? 'white' : 'black'
  end

  def fens
    moves.select do |move|
      move.before.split(' ')[1] == color[0]
    end.sort do |move|
      move.before.split(' ')[5].to_i
    end.map(&:before).reverse
  end
end
