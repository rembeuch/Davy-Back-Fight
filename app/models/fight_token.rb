class FightToken < ApplicationRecord
  belongs_to :player
  belongs_to :enemy, class_name: "Player"
end
