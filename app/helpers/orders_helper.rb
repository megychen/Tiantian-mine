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
      "已下单"
    when "paid"
      "已付款"
    when "shipping"
      "正在出货"
    when "shipped"
      "已出货"
    when "order_cancelled"
      "订单已取消"
    when "good_returned"
      "已退货"
    end
  end

  def render_order_confirmed_state(order)
    if order.is_confirmed?
       "已通过"
    else
       "待确认"
    end
  end
end
