class AddDefaultValueToPlayerPower < ActiveRecord::Migration[5.2]
  def change
    change_column :players, :player_power, :integer, :default => 0
  end
end
