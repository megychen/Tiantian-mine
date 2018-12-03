module OrdersHelper
  def render_order_paid_state(order)
    if order.is_paid?
      "已付款"
    else
       "未付款"
    end
  end

  def render_order_payment_state(order)
    case order.aasm_state
    when "order_placed"
      content_tag(:span, "已下单", :class => "label label-danger")
    when "paid"
      content_tag(:span, "已付款", :class => "label label-info")
    when "shipping"
      content_tag(:span, "正在出货", :class => "label label-info")
    when "shipped"
      content_tag(:span, "已出货", :class => "label label-primary")
    when "order_cancelled"
      content_tag(:span, "订单已取消", :class => "label label-default")
    when "good_returned"
      content_tag(:span, "已退货", :class => "label label-default")
    end
  end

  def render_order_confirmed_state(order)
    if order.is_confirmed?
      content_tag(:span, "已通过", :class => "label label-success")
    else
      content_tag(:span, "待确认", :class => "label label-warning")
    end
  end
end
