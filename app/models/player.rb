class Player < ApplicationRecord
  has_many :quest_logs
  has_many :rewards
  has_one :fight_token
  belongs_to :user


  LEVELS = [0, 999, 5999, 9999, 20999, 45999, 99999, 150999, 299999, 499999]


end
