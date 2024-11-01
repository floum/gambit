class Repertoire < ApplicationRecord
  has_many :repertoire_positions
  has_many :positions, through: :repertoire_positions
end
