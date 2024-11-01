class CreateRepertoirePositions < ActiveRecord::Migration[7.2]
  def change
    create_table :repertoire_positions do |t|
      t.references :repertoire, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
