class Position < ApplicationRecord
  has_many :position_counts
  has_many :moves

  START = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -"

  before_save :remove_move_count
  after_create :update_from_lichess_explorer

  def self.starting_position
    Position.find_or_create_by(fen: START)
  end

  def remove_move_count
    self.fen = fen.split(' ')[0..3].join(' ')
  end

  def update_from_lichess_explorer
    return if count && updated_at > 1.days.ago
    response = LichessExplorer.fetch(fen)
    self.count = response.count
    response.moves.each do |response_move|
      Move.find_or_create_by(position: self, uci: response_move.uci, san: response_move.san, count: response_move.count)
    end
    save
  end
end
