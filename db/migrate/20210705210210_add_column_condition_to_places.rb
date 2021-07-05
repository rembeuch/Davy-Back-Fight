class AddColumnConditionToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :condition, :string
  end
end
