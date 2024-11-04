class Repertoire < ApplicationRecord
  has_many :repertoire_positions
  has_many :positions, through: :repertoire_positions

  delegate :count, to: :position, prefix: false

  after_create :create_initial_positions

  def main_hole
    repertoire_positions.select do |repertoire_position|
      repertoire_position.repertoire_move.nil?
    end.max_by(&:count)
  end

  def create_initial_positions
    if white?
      RepertoirePosition.create(position: Position.starting_position, repertoire: self)
    else
      p = Position.starting_position
      p.update_from_lichess_explorer
      p.moves.each do |move|
        if move.popularity > 1.0 / precision
          RepertoirePosition.create(position: move.resulting_position, repertoire: self)
        end
      end
    end
  end
end
