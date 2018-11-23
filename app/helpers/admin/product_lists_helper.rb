module Admin::ProductListsHelper
  # def render_product_list_total_price(product_lists)
  #   sum = 0
  #   product_lists.each do |product_list|
  #     sum += product_list.product_price * product_list.quantity
  #   end
  #   sum
  # end

  def render_product_price_change(product_list)
    change = (product_list.product_price - product_list.new_product_price).to_f.abs / product_list.product_price
    number_to_percentage(change * 100, percision: 2)
  end
end
