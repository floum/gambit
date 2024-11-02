class Move < ApplicationRecord
  belongs_to :position
  has_many :move_counts

  delegate :fen, to: :position, prefix: false

  def count
    move_counts.order(:created_at).last.value
  end

  def popularity
    count.to_f / position.count
  end

  def resulting_position
    resulting_fen = Stockfish.new.compute_move(fen, uci)
    Position.find_or_create_by(fen: resulting_fen)
  end
end
