class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  monetize :amount_cents

  validates :address, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
end
