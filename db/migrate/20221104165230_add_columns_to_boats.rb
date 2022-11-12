class AddColumnsToBoats < ActiveRecord::Migration[5.2]
  def change
    add_column :boats, :type, :string
    add_column :boats, :level, :integer
    add_column :boats, :zone, :string
    add_column :boats, :moving, :boolean, default: false
    add_column :boats, :cost, :integer
    add_column :boats, :wood, :integer
  end
end
