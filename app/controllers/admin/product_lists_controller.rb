class Admin::ProductListsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def update
    @product_list = ProductList.find(params[:id])
    # old_price = @product_list.product_price
    # new_price = params[:product_price]

    if @product_list.update(product_list_params)
      current_user.logs.create(model: "ProductList", action: "#{@product_list.product_name} 订单价格#{@product_list.product_price}更改为#{@product_list.new_product_price}")
      # redirect_to admin_order_path(@product_list.order.id), notice: "更新成功"
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
