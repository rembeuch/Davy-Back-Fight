class Cart < ApplicationRecord
  belongs_to :user
  has_many :items

  def add_product(product)
    item = items.find_by(product: product)

    if item
      item.quantity += 1
    else
      item = items.new(product: product)
    end

    item
  end

  def total
    items.to_a.sum(&:total)
  end
end
