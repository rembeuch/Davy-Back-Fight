class AddImageToIsland < ActiveRecord::Migration[5.2]
  def change
    add_column :islands, :image, :string
  end
end
