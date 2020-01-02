class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pseudo, :string
    add_column :users, :avatar, :string
    add_column :users, :berrys, :integer
    add_column :users, :admin, :boolean
  end
end
