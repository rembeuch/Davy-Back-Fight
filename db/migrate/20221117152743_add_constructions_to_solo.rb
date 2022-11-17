class AddConstructionsToSolo < ActiveRecord::Migration[6.0]
  def change
    add_column :solos, :constructions, :string, array: true, default: ['chantier', 'port', 'caserne', 'canon']
  end
end
