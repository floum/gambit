class CreatePositionCounts < ActiveRecord::Migration[7.2]
  def change
    create_table :position_counts do |t|
      t.references :position, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
