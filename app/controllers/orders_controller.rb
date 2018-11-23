class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
    @addresses = current_user.addresses
  end

  def create
    @order = Order.new(order_params)
    # @address = Address.find(params[:order][:address_id])
    @cart_items = current_cart.cart_items.where(id: params[:cart_item_ids].split(","))
    @order.user = current_user
    @order.total = current_cart.total_price(@cart_items)
    # @order.address = @address

    unless current_cart.have_stock(@cart_items)
      render 'carts/checkout', alert: "库存不足，下单失败"
    end

    if @order.save!

      @cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end

      current_cart.clean_item(@cart_items)
      # OrderMailer.notify_order_placed(@order).deliver!
      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("alipay")
    @order.make_payment!

    redirect_to order_path(@order.token), notice: "使用支付宝成功完成付款"
  end

  def pay_with_wechat
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("wechat")
    @order.make_payment!

    redirect_to order_path(@order.token), notice: "使用微信成功完成付款"
  end

  def apply_to_cancel
    @order = Order.find_by_token(params[:id])
    flash[:notice] = "已提交申请"
    redirect_to order_path(@order.token)
  end

  def update_address
    @order = Order.find_by_token(params[:id])
    @order.update_columns(address_id: params[:address_id])
    render :json => { "success": true }
  end

  private

  def order_params
    params.require(:order).permit(:address_id)
  end
end
