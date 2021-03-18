class AddFightToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :fight, :string, default: "default"
  end
end
