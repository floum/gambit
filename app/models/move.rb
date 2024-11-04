class Move < ApplicationRecord
  belongs_to :position
  belongs_to :result, class_name: "Position"
  has_many :move_counts

  delegate :fen, to: :position, prefix: false

  before_save :create_result

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

  def create_result
    self.result = resulting_position
    save
  end
end
