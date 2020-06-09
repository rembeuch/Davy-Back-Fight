class AddSendToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :send, :boolean, :default => true
  end
end
