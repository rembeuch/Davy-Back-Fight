class CreateSolos < ActiveRecord::Migration[5.2]
  def change
    create_table :solos do |t|

      t.timestamps
    end
  end
end
