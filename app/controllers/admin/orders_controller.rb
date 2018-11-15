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
    current_user.logs.create(model: "Order", action: "确认订单出货中")
    redirect_to admin_order_path(@order)
  end

  def shipped
    @order.deliver!
    current_user.logs.create(model: "Order", action: "确认订单已出货")
    redirect_to admin_order_path(@order)
  end

  def cancel
    @order.cancel_order!
    current_user.logs.create(model: "Order", action: "取消订单")
    redirect_to admin_order_path(@order)
  end

  def return
    @order.return_good!
    current_user.logs.create(model: "Order", action: "确认订单已退货")
    redirect_to admin_order_path(@order)
  end

  def pay
    @order.make_payment!
    current_user.logs.create(model: "Order", action: "确认订单已付款")
    redirect_to admin_order_path(@order)
  end

  def unpay
    @order.unpay!
    current_user.logs.create(model: "Order", action: "撤销订单已付款确认")
    redirect_to admin_order_path(@order)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
