class Move < ApplicationRecord
  belongs_to :position
  belongs_to :result, class_name: "Position", optional: true

  delegate :fen, to: :position, prefix: false

  def popularity
    count.to_f / position.count
  end

  def resulting_position
    resulting_fen = Stockfish.new.compute_move(fen, uci)
    Position.find_or_create_by(fen: resulting_fen)
  end

  def create_result
    self.result = resulting_position
    save
  end
end
