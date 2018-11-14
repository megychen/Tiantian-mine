class Admin::ProductListsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def update
    puts params["product_list"]
    @product_list = ProductList.find(params[:id])

    if @product_list.update(product_list_params)
      redirect_to admin_order_path(@product_list.order.id), notice: "更新成功"
    else
      render :json => { "success": false, "message": "更新失败" }
    end
  end

  private

  def product_list_params
    params.permit(:product_price)
  end

end
