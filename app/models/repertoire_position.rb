class RepertoirePosition < ApplicationRecord
  belongs_to :repertoire
  belongs_to :position
  has_one :repertoire_move

  delegate :count, to: :position, prefix: false
  delegate :fen, to: :position, prefix: false
  delegate :moves, to: :position, prefix: false
end
