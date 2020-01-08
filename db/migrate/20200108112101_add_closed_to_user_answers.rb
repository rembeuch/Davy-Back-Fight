class AddClosedToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :closed, :boolean, :default => false
  end
end
