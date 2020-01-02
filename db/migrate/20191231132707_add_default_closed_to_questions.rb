class AddDefaultClosedToQuestions < ActiveRecord::Migration[5.2]
  def change
        change_column :questions, :closed, :boolean, :default => false
  end
end
