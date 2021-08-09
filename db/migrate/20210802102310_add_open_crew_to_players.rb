class AddOpenCrewToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :open_crew, :boolean, :default => false
  end
end
