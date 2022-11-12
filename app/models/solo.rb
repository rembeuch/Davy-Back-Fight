class Solo < ApplicationRecord
    has_one :computer
    has_many :zones
    has_many :persos
    has_many :buildings
    has_many :boats
    has_many :soldiers
    belongs_to :user
end
