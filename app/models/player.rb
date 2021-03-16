class Player < ApplicationRecord
  belongs_to :user
  POSITIONS = []
  Place.all.each do |place|
    POSITIONS.push(place.name)
  end
  validates :position, inclusion: { in: POSITIONS }
end
