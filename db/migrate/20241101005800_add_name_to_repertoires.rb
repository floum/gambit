class AddNameToRepertoires < ActiveRecord::Migration[7.2]
  def change
    add_column :repertoires, :name, :string
  end
end
