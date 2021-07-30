class AddReferencesToPlayersAndCrewColumn < ActiveRecord::Migration[5.2]
  def change
    add_reference :players, :crew, foreign_key: true
    add_column :crews, :name, :string, :default => ""
  end
end
