class RepertoirePosition < ApplicationRecord
  belongs_to :repertoire
  belongs_to :position
  has_one :repertoire_move, dependent: :destroy

  delegate :count, to: :position, prefix: false
  delegate :fen, to: :position, prefix: false
  delegate :moves, to: :position, prefix: false

  validates_uniqueness_of :position, scope: :repertoire

  before_save :compute_odds

  def compute_odds
    return 1 if fen == Position::START
  end
end
