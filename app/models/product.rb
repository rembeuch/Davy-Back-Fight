class Product < ApplicationRecord
  has_many :items
  monetize :price_cents
  mount_uploader :photo, PhotoUploader
end
