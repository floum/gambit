class Position < ApplicationRecord
  has_many :position_counts
  has_many :moves

  STARTING_FEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

  after_create :update_from_lichess_explorer

  def self.starting_position
    Position.find_or_create_by(fen: STARTING_FEN)
  end

  def update_from_lichess_explorer
    return if count && updated_at > 1.days.ago
    response = LichessExplorer.fetch(fen)
    self.count = response.count
    response.moves.each do |response_move|
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      p "Move found: #{response_move.san}"
      Move.find_or_create_by(position: self, uci: response_move.uci, san: response_move.san, count: response_move.count)
    end
    save
  end
end
