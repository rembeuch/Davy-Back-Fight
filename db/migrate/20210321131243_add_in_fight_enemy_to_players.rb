class AddInFightEnemyToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :in_fight_enemy, :string
  end
end
