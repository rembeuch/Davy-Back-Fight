class Add < ActiveRecord::Migration[5.2]
  def change
        add_column :players, :mob_health, :integer
  end
end
