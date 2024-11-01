class CreateRepertoires < ActiveRecord::Migration[7.2]
  def change
    create_table :repertoires do |t|
      t.string :color
      t.integer :precision

      t.timestamps
    end
  end
end
