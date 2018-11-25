class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  scope :recent, -> { order("created_at DESC") }
end
