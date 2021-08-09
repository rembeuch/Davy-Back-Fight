class AddVisitedIslandsAndPlacesForPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :visited_island, :string, array: true, default: []
    add_column :players, :visited_place, :string, array: true, default: []
  end
end
