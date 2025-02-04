class CreateRepertoireMoveAttempts < ActiveRecord::Migration[7.2]
  def change
    create_table :repertoire_move_attempts do |t|
      t.boolean :success
      t.references :repertoire_move, null: false, foreign_key: true

      t.timestamps
    end
  end
end
