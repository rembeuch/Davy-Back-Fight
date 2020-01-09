class Product < ApplicationRecord
  monetize :price_cents
  mount_uploader :photo, PhotoUploader

end
