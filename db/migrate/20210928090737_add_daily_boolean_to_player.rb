class AddDailyBooleanToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :daily, :boolean, :default => false
  end
end
