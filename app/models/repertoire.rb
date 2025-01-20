class Repertoire < ApplicationRecord
  has_many :repertoire_moves, dependent: :destroy
  has_many :moves, through: :repertoire_moves

  def color
    white? ? 'white' : 'black'
  end
end
