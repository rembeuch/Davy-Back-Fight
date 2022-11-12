class AddColumnsToComputers < ActiveRecord::Migration[5.2]
  def change
    add_column :computers, :jour, :integer, default: 0
    add_column :computers, :goals, :string, array: true, default: []
    add_column :computers, :berrys, :integer, default: 500
    add_column :computers, :wood, :integer, default: 500
    add_column :computers, :side, :string
  end
end
