class AddColumnsToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :status, :string, :default => "à venir"
    add_column :tournaments, :title, :string
  end
end
