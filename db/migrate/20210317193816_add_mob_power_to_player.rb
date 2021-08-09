class AddMobPowerToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :mob_power, :integer
  end
end
