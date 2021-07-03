class Mob < ApplicationRecord
  belongs_to :place
  has_many :rewards
end
