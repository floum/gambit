class AddResultToMoves < ActiveRecord::Migration[7.2]
  def change
    add_reference :moves, :result, null: false, foreign_key: { to_table: :positions }
  end
end
