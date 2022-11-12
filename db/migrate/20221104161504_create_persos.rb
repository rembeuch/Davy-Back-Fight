class CreatePersos < ActiveRecord::Migration[5.2]
  def change
    create_table :persos do |t|

      t.timestamps
    end
  end
end
