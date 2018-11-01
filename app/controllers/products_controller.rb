class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
    else
      @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
      @cart_item.quantity += 1
      @cart_item.save!
    end
  end
end
