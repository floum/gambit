class CreateMoveAnalyses < ActiveRecord::Migration[7.2]
  def change
    create_table :move_analyses do |t|
      t.references :move, null: false, foreign_key: true
      t.integer :depth
      t.float :value

      t.timestamps
    end
  end
end
