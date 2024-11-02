class RepertoireMove < ApplicationRecord
  belongs_to :move
  belongs_to :repertoire_position
  has_one :repertoire, through: :repertoire_position
end
