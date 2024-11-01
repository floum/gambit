class CreateRepertoireMoves < ActiveRecord::Migration[7.2]
  def change
    create_table :repertoire_moves do |t|
      t.references :move, null: false, foreign_key: true
      t.references :repertoire_position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
