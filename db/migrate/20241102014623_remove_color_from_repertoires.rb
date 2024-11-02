class RemoveColorFromRepertoires < ActiveRecord::Migration[7.2]
  def change
    remove_column :repertoires, :color, :string
  end
end
