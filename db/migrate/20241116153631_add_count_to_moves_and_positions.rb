class AddCountToMovesAndPositions < ActiveRecord::Migration[7.2]
  def change
    add_column :moves, :count, :integer
    add_column :positions, :count, :integer
  end
end
