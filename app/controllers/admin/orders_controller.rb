class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_order, except: [:index]

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @product_lists = @order.product_lists
    @certificates = @order.certificates
  end

  def ship
    @order.ship!
    redirect_to admin_order_path(@order)
  end

  def shipped
    @order.deliver!
    redirect_to admin_order_path(@order)
  end

  def cancel
    @order.cancel_order!
    redirect_to admin_order_path(@order)
  end

  def return
    @order.return_good!
    redirect_to admin_order_path(@order)
  end

  def pay
    @order.make_payment!
    redirect_to admin_order_path(@order)
  end

  def unpay
    @order.unpay!
    redirect_to admin_order_path(@order)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
