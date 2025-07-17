class CreateGameMoves < ActiveRecord::Migration[7.2]
  def change
    create_table :game_moves do |t|
      t.references :game, null: false, foreign_key: true
      t.references :move, null: false, foreign_key: true

      t.timestamps
    end
  end
end
