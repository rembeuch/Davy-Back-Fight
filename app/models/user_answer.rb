class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :amount, presence: true
end
