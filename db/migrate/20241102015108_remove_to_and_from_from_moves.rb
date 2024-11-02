class RemoveToAndFromFromMoves < ActiveRecord::Migration[7.2]
  def change
    remove_column :moves, :to, :string
    remove_column :moves, :from, :string
  end
end
