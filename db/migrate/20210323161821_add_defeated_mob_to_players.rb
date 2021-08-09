class AddDefeatedMobToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :defeated_mob, :string, array: true, default: []
    add_column :mobs, :condition, :string
  end
end
