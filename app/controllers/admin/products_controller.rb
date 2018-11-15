class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.all
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

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end
end
