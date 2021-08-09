class AddPlayerPowerToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :player_power, :integer
  end
end
