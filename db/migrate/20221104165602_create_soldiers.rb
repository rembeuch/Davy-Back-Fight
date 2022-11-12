class CreateSoldiers < ActiveRecord::Migration[5.2]
  def change
    create_table :soldiers do |t|

      t.timestamps
    end
  end
end
