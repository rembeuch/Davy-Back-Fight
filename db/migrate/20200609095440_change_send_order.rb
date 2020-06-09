class ChangeSendOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :send
    add_column :orders, :mailing, :boolean, :default => true
  end
end
