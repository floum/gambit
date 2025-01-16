class RepertoireMove < ApplicationRecord
  belongs_to :move
  belongs_to :repertoire

  delegate :before, to: :move, prefix: false

  validates_with RepertoireMoveValidator
end
