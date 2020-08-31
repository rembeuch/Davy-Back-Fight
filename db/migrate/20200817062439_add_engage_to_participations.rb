class AddEngageToParticipations < ActiveRecord::Migration[5.2]
  def change
    add_column :participations, :engage, :boolean, :default => false
  end
end
