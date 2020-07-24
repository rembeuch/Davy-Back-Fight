class AddChoicesToQuizzes < ActiveRecord::Migration[5.2]
  def change
        add_column :quizzes, :choices, :text, array: true, default: []
  end
end
