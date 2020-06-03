class AddTagToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :tags, :string, array: true, default: []
  end
end
