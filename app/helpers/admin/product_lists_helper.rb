module Admin::ProductListsHelper
  def render_product_list_total_price(product_lists)
    sum = 0
    product_lists.each do |product_list|
      sum += product_list.product_price * product_list.quantity
    end
    sum
  end
end
