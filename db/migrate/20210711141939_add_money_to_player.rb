class AddMoneyToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :money, :integer, :default => 0
  end
end
