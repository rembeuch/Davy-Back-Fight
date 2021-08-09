class AddPriceToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :price, :integer, :default => 0
  end
end
