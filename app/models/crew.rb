class Crew < ApplicationRecord
  has_many :players

  validates :name, uniqueness: true, presence: true, length: { maximum: 25,
    too_long: "%{count} charactères max" }

end
