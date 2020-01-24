class ChangeAmountOrder < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :amount_cents, :float, :default => 0.00, null: false
  end
end
