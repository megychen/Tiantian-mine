class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
    @certificates = @order.certificates
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    redirect_to admin_order_path(@order)
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to admin_order_path(@order)
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    redirect_to admin_order_path(@order)
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to admin_order_path(@order)
  end
end
