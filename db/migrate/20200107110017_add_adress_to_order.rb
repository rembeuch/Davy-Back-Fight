class AddAdressToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :zipcode, :integer
    add_column :orders, :country, :string
  end
end
