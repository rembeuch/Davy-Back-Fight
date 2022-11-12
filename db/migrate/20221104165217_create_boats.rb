class CreateBoats < ActiveRecord::Migration[5.2]
  def change
    create_table :boats do |t|

      t.timestamps
    end
  end
end
