class ProductsController < ApplicationController
  def index
    @products = Product.all
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
