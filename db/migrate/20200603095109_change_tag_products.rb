class ChangeTagProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :tags
    add_column :products, :tags, :string, default: ""

  end
end
