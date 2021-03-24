class CreateQuestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :quest_logs do |t|
      t.references :player, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
