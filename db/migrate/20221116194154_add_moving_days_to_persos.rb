class AddMovingDaysToPersos < ActiveRecord::Migration[6.0]
  def change
    add_column :persos, :moving_days, :integer
  end
end
