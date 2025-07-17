class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.timestamps
      t.string :result
      t.string :white
      t.string :black
      t.string :site
    end
  end
end
