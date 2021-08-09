class AddCategoryToIsland < ActiveRecord::Migration[5.2]
  def change
    add_column :islands, :category, :string
  end
end
