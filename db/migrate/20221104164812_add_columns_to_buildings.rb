class AddColumnsToBuildings < ActiveRecord::Migration[5.2]
  def change
    add_column :buildings, :type, :string
    add_column :buildings, :zone, :string
    add_column :buildings, :level, :integer
    add_column :buildings, :cost, :integer
    add_column :buildings, :wood, :integer
  end
end
