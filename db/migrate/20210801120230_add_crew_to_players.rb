class AddCrewToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :crew, :string, :default => ""
  end
end
