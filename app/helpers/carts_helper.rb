module CartsHelper
  def render_cart_total_price(cart, cart_items)
    cart.total_price(cart_items)
  end
end
