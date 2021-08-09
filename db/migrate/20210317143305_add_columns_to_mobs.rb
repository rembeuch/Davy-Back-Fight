class AddColumnsToMobs < ActiveRecord::Migration[5.2]
  def change
    add_column :mobs, :image, :string
    add_column :mobs, :bonus, :string
    add_column :mobs, :exp, :integer
  end
end
