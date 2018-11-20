class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order       = order
    @user        = order.user
    @product_lists = @order.product_lists

    mail(to: "megy.chen203@gmail.com" , subject: "#{@user.email}正在下单，以下是这次购物明细 #{order.token}")
  end

  def send_verification_code(user, code)
    @user = user
    @code = code
    mail(to: @user.email , subject: "验证码")
  end
end
