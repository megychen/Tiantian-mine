class Admin::OrdersController < AdminController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required!
  before_action :find_order, except: [:index]

  def index
    if params[:order] == "checking"
      @orders = Order.where(:is_confirmed => false).recent.paginate(:page => params[:page], :per_page => 20)
    end

    if params[:order] == "obligation"
      @orders = Order.where(:is_confirmed => true, :is_paid => false).recent.paginate(:page => params[:page], :per_page => 20)
    end

    if params[:order] == "paid"
      @orders = Order.where(:is_confirmed => true, :is_paid => true).recent.paginate(:page => params[:page], :per_page => 20)
    end

    if params[:order].nil?
      @orders = Order.all.recent.paginate(:page => params[:page], :per_page => 20)
    end

  end

  def show
    @product_lists = @order.product_lists
    @certificates = @order.certificates
  end

  def ship
    @order.ship!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 确认订单#{@order.order_no}出货中")
    redirect_to admin_order_path(@order)
  end

  def shipped
    @order.deliver!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 确认订单#{@order.order_no}已出货")
    redirect_to admin_order_path(@order)
  end

  def cancel
    @order.cancel_order!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 取消订单#{@order.order_no}")
    redirect_to admin_order_path(@order)
  end

  def return
    @order.return_good!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 确认订单#{@order.order_no}已退货")
    redirect_to admin_order_path(@order)
  end

  def confirm
    @order.confirm!

    recipients = User.where(id: @order.user.id)
    message_body = "订单审核通过"
    message_subject = "#{@order.order_no}"
    conversation = current_user.send_message(recipients, message_body, message_subject).conversation

    current_user.logs.create(model: "Order", action: "#{current_user.email} 确认订单#{@order.order_no}审核通过")
    redirect_to admin_order_path(@order)
  end

  def pay
    @order.make_payment!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 确认订单#{@order.order_no}已付款")
    redirect_to admin_order_path(@order)
  end

  def unpay
    @order.unpay!
    current_user.logs.create(model: "Order", action: "#{current_user.email} 撤销订单#{@order.order_no}已付款确认")
    redirect_to admin_order_path(@order)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
