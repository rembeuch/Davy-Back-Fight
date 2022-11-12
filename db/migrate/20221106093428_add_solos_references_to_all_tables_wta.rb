class AddSolosReferencesToAllTablesWta < ActiveRecord::Migration[5.2]
  def change
    add_reference :computers, :solo, foreign_key: true
    add_reference :persos, :solo, foreign_key: true
    add_reference :zones, :solo, foreign_key: true
    add_reference :buildings, :solo, foreign_key: true
    add_reference :boats, :solo, foreign_key: true
    add_reference :soldiers, :solo, foreign_key: true
    add_column :buildings, :side, :string
    add_column :boats, :side, :string
    add_column :soldiers, :side, :string
  end
end
