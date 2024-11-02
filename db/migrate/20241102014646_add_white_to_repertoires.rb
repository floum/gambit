class AddWhiteToRepertoires < ActiveRecord::Migration[7.2]
  def change
    add_column :repertoires, :white, :boolean
  end
end
