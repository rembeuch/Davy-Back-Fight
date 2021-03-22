class CreateFightTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :fight_tokens do |t|
      t.references :player, foreign_key: true
      t.references :enemy, foreign_key: {to_table: :players}

      t.timestamps
    end
  end
end
