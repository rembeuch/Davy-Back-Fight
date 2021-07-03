class AddColumnsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :name, :string
    add_column :rewards, :category, :string
    add_column :rewards, :image, :string
  end
end
