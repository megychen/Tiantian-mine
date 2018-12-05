class Admin::ProductListsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def update
    @product_list = ProductList.find(params[:id])

    if @product_list.update(product_list_params)

      recipients = User.where(id: @product_list.order.user.id)
      message_body = "#{@product_list.product_name} 订单价格#{@product_list.product_price}更改为#{@product_list.new_product_price}"
      message_subject = "#{@product_list.order.order_no}订单价格变更"
      conversation = current_user.send_message(recipients, message_body, message_subject).conversation

      current_user.logs.create(model: "ProductList", action: "#{@product_list.product_name} 订单价格#{@product_list.product_price}更改为#{@product_list.new_product_price}")
      render :json => { "success": true }
    else
      render :json => { "success": false, "message": "更新失败" }
    end
  end

  private

  def product_list_params
    params.permit(:new_product_price)
  end

end
