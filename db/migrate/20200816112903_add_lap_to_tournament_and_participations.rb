class AddLapToTournamentAndParticipations < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :lap, :integer, :default => 1
    add_column :participations, :lap, :integer, :default => 1

  end
end
