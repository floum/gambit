class AddUciToMoves < ActiveRecord::Migration[7.2]
  def change
    add_column :moves, :uci, :string
    add_column :moves, :san, :string
  end
end
