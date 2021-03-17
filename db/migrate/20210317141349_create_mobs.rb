class CreateMobs < ActiveRecord::Migration[5.2]
  def change
    create_table :mobs do |t|
      t.string :name
      t.integer :level
      t.references :place, foreign_key: true
      t.integer :health

      t.timestamps
    end
  end
end
