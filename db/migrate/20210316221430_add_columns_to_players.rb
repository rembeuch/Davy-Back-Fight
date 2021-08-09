class AddColumnsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :health, :integer, :default => 3
    add_column :players, :level, :integer, :default => 1
    add_column :players, :exp, :integer, :default => 0
  end
end
