class AddShipColumnsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :ship_options, :string, array: true, default: []
    add_column :players, :ship_level, :integer, default: 0
  end
end
