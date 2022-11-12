class AddColumnsToSoldiers < ActiveRecord::Migration[5.2]
  def change
    add_column :soldiers, :type, :string
    add_column :soldiers, :level, :integer
    add_column :soldiers, :zone, :string
    add_column :soldiers, :moving, :boolean, default: false
    add_column :soldiers, :cost, :integer
  end
end
