class Repertoire < ApplicationRecord
  has_many :repertoire_positions, dependent: :destroy
  has_many :positions, through: :repertoire_positions
  has_many :repertoire_moves, through: :repertoire_positions
  has_many :moves, through: :repertoire_moves

  delegate :count, to: :position, prefix: false

  before_create :create_initial_positions
  after_initialize :set_defaults

  def set_defaults
    self.precision ||= 40
  end

  def main_hole
    repertoire_positions.select do |repertoire_position|
      repertoire_position.repertoire_move.nil?
    end.max_by(&:count)
  end

  def create_initial_positions
    if white?
      repertoire_positions << RepertoirePosition.create(position: Position.starting_position)
    else
      Position.starting_position.moves.each do |move|
        if move.popularity > 1.0 / precision
          repertoire_positions << RepertoirePosition.create(position: move.resulting_position)
        end
      end
    end
  end
end
