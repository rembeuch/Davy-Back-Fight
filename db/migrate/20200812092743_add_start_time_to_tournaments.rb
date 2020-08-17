class AddStartTimeToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :start, :datetime
  end
end
