class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product

  def add_product_to_cart(product, quantity = 1)
    ci = cart_items.build
    ci.product = product
    ci.quantity = quantity
    ci.save
  end

  def total_price(cart_items)
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum = sum + cart_item.quantity * cart_item.product.price
      end
    end
    sum
  end

  def clean_item(cart_items)
    cart_items.destroy_all
  end

  def clean!
    cart_items.destroy_all
  end
end
