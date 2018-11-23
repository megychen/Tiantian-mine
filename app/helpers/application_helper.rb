module ApplicationHelper
  def render_product_list_total_price(product_lists)
    sum = 0
    product_lists.each do |product_list|
      if product_list.new_product_price.present?
        sum += product_list.new_product_price * product_list.quantity
      else
        sum += product_list.product_price * product_list.quantity
      end
    end
    sum
  end
end
