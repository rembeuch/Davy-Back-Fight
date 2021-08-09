class AddFightBooleanToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :in_fight, :boolean, :default => false
  end
end
