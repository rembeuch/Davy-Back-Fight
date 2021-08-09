class AddCategoryToMobsAndWantedToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :wanted, :integer, :default => 0
    add_column :mobs, :category, :string, :default => ""
  end
end
