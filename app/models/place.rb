class Place < ApplicationRecord
  belongs_to :island
  has_many :mobs
end
