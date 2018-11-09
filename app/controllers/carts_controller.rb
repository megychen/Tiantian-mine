class CartsController < ApplicationController
  def clean
    current_cart.clean!
    flash[:warning] = "已清空购物车"
    redirect_to carts_path
  end

  def checkout
    @order = Order.new
    @addresses = current_user.addresses

    if params[:product_id].present?
      @cart_items = current_cart.cart_items.where(product_id: params[:product_id])
    else
      @cart_items = current_cart.cart_items
    end
  end
end
