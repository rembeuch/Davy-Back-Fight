class AddColumnsToZones < ActiveRecord::Migration[5.2]
  def change
    add_column :zones, :name, :string
    add_column :zones, :affinity_number, :integer, default: 50
    add_column :zones, :affinity, :string
    add_column :zones, :position, :integer
    add_column :zones, :slot, :integer
  end
end
