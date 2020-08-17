class ChangeQuizzesColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :numero, :integer
    remove_column :quizzes, :choices
  end
end
