class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_cart.cart_items.recent
  end

  def clean
    current_cart.clean!
    flash[:warning] = "已清空购物车"
    redirect_to carts_path
  end

  def checkout
    @order = Order.new
    @addresses = current_user.addresses
    @verification = Verification.new

    if params[:cart_item_ids].present?
      @cart_items = current_cart.cart_items.where(id: params[:cart_item_ids].split(","))
    else
      @cart_items = current_cart.cart_items
    end
  end
end
