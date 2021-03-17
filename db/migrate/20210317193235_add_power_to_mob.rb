class AddPowerToMob < ActiveRecord::Migration[5.2]
  def change
    add_column :mobs, :power, :integer
  end
end
