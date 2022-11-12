class AddSpecialToPersos < ActiveRecord::Migration[5.2]
  def change
    add_column :persos, :special, :boolean, default: false
  end
end
