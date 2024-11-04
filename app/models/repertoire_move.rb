class RepertoireMove < ApplicationRecord
  belongs_to :move
  belongs_to :repertoire_position
  has_one :repertoire, through: :repertoire_position

  delegate :fen, to: :repertoire_position, prefix: false
  delegate :resulting_position, to: :move, prefix: false

  after_create :prepare_repertoire_positions

  def prepare_repertoire_positions
    resulting_position.update_from_lichess_explorer
    resulting_position.moves.each do |move|
      if move.popularity > 1.0 / repertoire.precision
        RepertoirePosition.create(position: move.resulting_position, repertoire: repertoire)
      end
    end
  end
end
