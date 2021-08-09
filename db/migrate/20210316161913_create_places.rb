class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.string :image
      t.references :island, foreign_key: true

      t.timestamps
    end
  end
end
