class AddMaxHealthToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :max_health, :integer, default: 3
  end
end
