class AddQuestionToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :question, :string
  end
end
