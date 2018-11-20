class VerificationsController < ApplicationController
  before_action :authenticate_user!

  def verify
    identity = params[:identity]
    code = params[:code]

    verification = Verification.find_by_identity(identity)
    if verification && verification.code == code
      render :json => { "success": true, message: "验证成功" }
    else
      render :json => { "success": false, message: "验证码错误" }
    end
  end

  def create
    @verification = Verification.new(verification_params)
    identity = params[:verification][:identity]
    code = rand(10000..99999)
    @verification.code = code

    if Verification.exists?(:identity => identity)
      Verification.find_by_identity(identity).update_columns(code: code)
      OrderMailer.send_verification_code(current_user, code).deliver!
      render :json => { "success": true, message: "发送成功" }
    elsif @verification.save
      OrderMailer.send_verification_code(current_user, code).deliver!
      render :json => { "success": true, message: "发送成功" }
    else
      render :json => { "success": false, message: "发送失败" }
    end
  end

  private

  def verification_params
    params.require(:verification).permit(:identity)
  end
end
