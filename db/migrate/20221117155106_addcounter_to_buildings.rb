class AddcounterToBuildings < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :destination, :string
    add_column :buildings, :moving_days, :integer
    add_column :buildings, :constructions_days, :integer
    add_column :boats, :destination, :string
    add_column :boats, :moving_days, :integer
    add_column :boats, :constructions_days, :integer
    add_column :soldiers, :destination, :string
    add_column :soldiers, :moving_days, :integer
    add_column :soldiers, :constructions_days, :integer
  end
end
