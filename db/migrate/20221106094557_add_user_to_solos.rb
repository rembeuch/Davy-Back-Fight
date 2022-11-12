class AddUserToSolos < ActiveRecord::Migration[5.2]
  def change
    add_reference :solos, :user, foreign_key: true
  end
end
