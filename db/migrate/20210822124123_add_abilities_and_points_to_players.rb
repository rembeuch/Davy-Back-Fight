class AddAbilitiesAndPointsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :abilities, :string, array: true, default: []
    add_column :players, :abilities_points, :integer, default: 0
  end
end
