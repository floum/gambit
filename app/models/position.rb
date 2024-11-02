class Position < ApplicationRecord
  has_many :position_counts
  has_many :moves

  STARTING_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

  def self.starting_position
    Position.find_by(fen: STARTING_FEN) || Position.create(fen: STARTING_FEN)
  end

  def count
    position_counts.order(:created_at).last.value
  end

  def update_from_lichess_explorer
    response = LichessExplorer.fetch(fen)
    PositionCount.create(value: response.count, position: self)
    response.moves.each do |response_move|
      move = Move.find_by(position: self, uci: response_move.uci)
      move = Move.create(position: self, uci: response_move.uci, san: response_move.san) unless move
      MoveCount.create(value: response_move.count, move: move)
    end
  end
end
