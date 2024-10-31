class CreateMoves < ActiveRecord::Migration[7.2]
  def change
    create_table :moves do |t|
      t.references :position, null: false, foreign_key: true
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
