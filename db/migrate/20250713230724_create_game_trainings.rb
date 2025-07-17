class CreateGameTrainings < ActiveRecord::Migration[7.2]
  def change
    create_table :game_trainings do |t|
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
