class AddArrayOfLinkToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :carousel, :text, array: true, default: []
  end
end
