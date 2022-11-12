class AddColumnsToSolo < ActiveRecord::Migration[5.2]
  def change
    add_column :solos, :jour, :integer, default: 0
    add_column :solos, :goals, :string, array: true, default: []
    add_column :solos, :berrys, :integer, default: 500
    add_column :solos, :wood, :integer, default: 500
    add_column :solos, :side, :string
  end
end
