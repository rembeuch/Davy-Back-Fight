class AddImageToQuetlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :quest_logs, :image, :string, :default => ""
  end
end
