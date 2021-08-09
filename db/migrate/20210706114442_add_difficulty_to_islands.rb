class AddDifficultyToIslands < ActiveRecord::Migration[5.2]
  def change
    add_column :islands, :difficulty, :integer, :default => 1
  end
end
