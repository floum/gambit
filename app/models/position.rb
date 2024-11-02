class Position < ApplicationRecord
  has_many :position_counts
  has_many :moves

  STARTING_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

  after_create :update_from_lichess_explorer

  def self.starting_position
    Position.find_or_create_by(fen: STARTING_FEN) 
  end

  def count
    position_counts.order(:created_at).last.value
  end

  def update_from_lichess_explorer
    return if !position_counts.empty? && position_counts.order(:created_at).pluck(:created_at).last > 14.day.ago
    response = LichessExplorer.fetch(fen)
    PositionCount.create(value: response.count, position: self)
    response.moves.each do |response_move|
      move = Move.find_or_create_by(position: self, uci: response_move.uci, san: response_move.san)
      MoveCount.create(value: response_move.count, move: move)
    end
  end
end
