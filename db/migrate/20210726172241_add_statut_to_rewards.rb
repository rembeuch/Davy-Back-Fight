class AddStatutToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :statut, :string, :default => "Non équipé"
  end
end
