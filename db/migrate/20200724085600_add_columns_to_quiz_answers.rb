class AddColumnsToQuizAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :quiz_answers, :description, :string
    add_column :quiz_answers, :status, :boolean, :default => false

  end
end
