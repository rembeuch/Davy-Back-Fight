class AddStatusToParticipations < ActiveRecord::Migration[5.2]
  def change
    add_column :participations, :status, :string, :default => "Validée"
  end
end
