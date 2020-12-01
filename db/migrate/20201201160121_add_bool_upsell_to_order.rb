class AddBoolUpsellToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :upsell, :boolean, :default => false
  end
end
