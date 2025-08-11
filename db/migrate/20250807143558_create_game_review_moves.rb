class CreateGameReviewMoves < ActiveRecord::Migration[7.2]
  def change
    create_table :game_review_moves do |t|
      t.references :game_review, null: false, foreign_key: true
      t.references :move, null: false, foreign_key: true

      t.timestamps
    end
  end
end
