class ChangeDefaultValueToBerry < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :berrys, :integer, :default => 10000
  end
end
