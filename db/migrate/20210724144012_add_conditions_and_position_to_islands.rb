class AddConditionsAndPositionToIslands < ActiveRecord::Migration[5.2]
  def change
    add_column :islands, :condition, :string, :default => ""
    add_column :islands, :position, :integer, :default => 0
  end
end
