class AddInFightMobColumnToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :in_fight_mob, :string, :default => ""
  end
end
