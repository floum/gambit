class RepertoireMove < ApplicationRecord
  belongs_to :move
  belongs_to :repertoire

  has_many :attempts, class_name: 'RepertoireMoveAttempt', dependent: :destroy

  delegate :before, to: :move, prefix: false
  delegate :after, to: :move, prefix: false
  delegate :san, to: :move, prefix: false
  delegate :uci, to: :move, prefix: false
  delegate :sheet_notation, to: :move, prefix: false

  validates_with RepertoireMoveValidator
end
