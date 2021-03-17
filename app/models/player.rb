class Player < ApplicationRecord
  belongs_to :user
  POSITIONS = []
  Place.all.each do |place|
    POSITIONS.push(place.name)
  end
  validates :position, inclusion: { in: POSITIONS }

  LEVELS = [0, 1000, 3000, 6000, 10000, 15000, 21000, 28000, 36000, 45000]
end
