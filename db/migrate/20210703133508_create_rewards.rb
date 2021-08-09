class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.references :mob, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
