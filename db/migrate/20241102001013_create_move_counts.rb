class CreateMoveCounts < ActiveRecord::Migration[7.2]
  def change
    create_table :move_counts do |t|
      t.references :move, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
