class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.price != params[:product][:price].to_i
      current_user.logs.create(model: "Product", action: "#{@product.title} 价格#{@product.price}更改为#{params[:product][:price]}")
    end

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def start_trading
    @product = Product.find(params[:id])
    @product.start!
    current_user.logs.create(model: "Product", action: "恢复 #{@product.title} 的交易")
    redirect_to admin_products_path, notice: "#{@product.title} 已恢复交易"
  end

  def stop_trading
    @product = Product.find(params[:id])
    @product.stop!
    current_user.logs.create(model: "Product", action: "暂停 #{@product.title} 的交易")
    redirect_to admin_products_path, alert: "#{@product.title} 已暂停交易"
  end

  def bulk_update
    if params[:product_action] == "暂停交易"
      is_maintainable = true
    elsif params[:product_action] == "恢复交易"
      is_maintainable = false
    end

    Array(params[:ids]).each do |product_id|
      product = Product.find(product_id)
      product.is_maintainable = is_maintainable
      product.save
    end

    current_user.logs.create(model: "Product", action: "批次#{params[:product_action]}")

    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end
end
