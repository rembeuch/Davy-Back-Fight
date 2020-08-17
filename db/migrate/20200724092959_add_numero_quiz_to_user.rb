class AddNumeroQuizToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :numero_quiz, :integer, :default => 0
  end
end
