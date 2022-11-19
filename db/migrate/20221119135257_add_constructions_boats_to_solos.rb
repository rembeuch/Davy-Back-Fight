class AddConstructionsBoatsToSolos < ActiveRecord::Migration[6.0]
  def change
    add_column :solos, :constructions_boats, :string, array: true, default: ['barque', 'caravelle']
    add_column :solos, :constructions_soldiers, :string, array: true, default: ['soldats', 'lieutenants']
  end
end
