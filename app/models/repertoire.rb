class Repertoire < ApplicationRecord
  has_many :repertoire_moves, dependent: :destroy
  has_many :moves, through: :repertoire_moves

  def self.import(json_data)
    repertoire = Repertoire.new
    repertoire.white = json_data["white"]
    repertoire.name = json_data["name"]
    json_data["moves"].each do |move_info|
      move = Move.find_or_create_by(
        before: move_info["before"],
        after: move_info["after"],
        uci: move_info["uci"],
        san: move_info["san"]
      )
      repertoire.repertoire_moves << RepertoireMove.new(move:)
    end
    repertoire.save
  end

  def color
    white? ? "white" : "black"
  end

  def size
    moves.size
  end
end
