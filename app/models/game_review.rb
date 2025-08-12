class GameReview < ApplicationRecord
  belongs_to :game

  has_many :game_review_moves

  delegate :moves, to: :game, prefix: false

  def size
    game.review_size
  end

  def game_name
    game.display_name
  end

  def color
    game.review_as_white ? 'white' : 'black'
  end

  def review_moves
    moves.select {|move| game.review_as_white ? move.white? : move.black? }
  end

  def moves_to_review
    moves.select do |move|
      !game_review_moves.map(&:before).include?(move.before)
    end
  end

  def fens
    moves_to_review.select do |move|
      move.color == color
    end.sort do |move|
      move.number
    end.map(&:before).reverse
  end

  def done?
    size == game_review_moves.size
  end
end
