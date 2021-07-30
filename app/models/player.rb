class Player < ApplicationRecord
  has_many :quest_logs
  has_many :rewards
  has_one :fight_token
  belongs_to :user
  belongs_to :crew


  LEVELS = [0, 999, 2999, 5999, 9999, 14999, 20999, 27999, 35999, 44999]


end
