class ChangeColumnInFightEnemyDefaultToEmptyString < ActiveRecord::Migration[5.2]
  def change
    change_column :players, :in_fight_enemy, :string, :default => ""
  end
end
