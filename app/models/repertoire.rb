class Repertoire < ApplicationRecord
  has_many :repertoire_moves
  has_many :moves, through: :repertoire_moves

  def color
    white? ? 'white' : 'black'
  end
end
