class ProductsController < ApplicationController
  def index
    @products = Product.all
    @orders = current_user.orders.where(:is_confirmed => true, :is_paid => false).recent.limit(3) if current_user.present?
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if params[:quantity].present?
      quantity = params[:quantity].to_i
    else
      quantity = 1
    end

    if quantity > @product.quantity
      render :json => { "success": false, message: "数量不足以加入购物车" }
      return
    end

    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product, quantity)
    else
      @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
      @cart_item.quantity += quantity
      @cart_item.save!
    end

    render :json => { "success": true }
  end
end
