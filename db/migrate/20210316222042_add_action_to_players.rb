class AddActionToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :action, :integer, :default => 3
  end
end
