class AddStatutToBuildings < ActiveRecord::Migration[5.2]
  def change
    rename_column :buildings, :type, :version
    rename_column :boats, :type, :version
    rename_column :soldiers, :type, :version
    add_column :buildings, :statut, :string
    add_column :boats, :statut, :string
    add_column :soldiers, :statut, :string

  end
end
