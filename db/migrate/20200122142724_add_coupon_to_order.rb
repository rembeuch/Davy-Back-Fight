class AddCouponToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :coupon, :string
  end
end
