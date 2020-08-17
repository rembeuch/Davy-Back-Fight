class ChangeCountryOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :country, :nation
  end
end
