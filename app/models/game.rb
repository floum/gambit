class Game < ApplicationRecord
  has_many :game_moves, dependent: :destroy
  has_many :moves, through: :game_moves

  def display_name
    "#{white} - #{black} | #{result}"
  end

  def size
    white_moves.size
  end

  def sorted_moves
    moves.sort_by do |move|
      [-move.number, move.color]
    end.reverse
  end

  def black_acpl
    cpls = moves.select do |move|
      move.black?
    end.map(&:cpl)
    ((cpls.reduce(:+) / cpls.size).round(2) * 100).to_i
  end

  def white_acpl
    cpls = moves.select do |move|
      move.white?
    end.map(&:cpl)
    ((cpls.reduce(:+) / cpls.size).round(2) * 100).to_i
  end

  def white_moves
    moves.select(&:white?).sort_by(&:number)
  end

  def black_moves
    moves.select(&:black?).sort_by(&:number)
  end

  def notation
    white_moves.map(&:san).zip(black_moves.map(&:san))
      .map { |item| item.join(' ') }
      .map
      .each_with_index { |move, index| "#{index+1}.#{move}" }
      .join(' ')
  end

  def evaluations
    sorted_moves.map(&:evaluation)
  end
end
