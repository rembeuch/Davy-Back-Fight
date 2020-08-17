class AddDefaultStatusToAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :status, :string, :default => "En cours"
  end
end
