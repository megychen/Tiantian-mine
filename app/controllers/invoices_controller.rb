class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order

  def new
    @invoice = @order.build_invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.order = order

    if @order.save
      redirect_to order_path(@order.token)
    else
      render :new
    end
  end

  def edit
    @invoice = @order.invoice.find(params[:id])
  end

  def update
    @invoice = @order.invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to order_path(@order.token)
    else
      render :edit
    end
  end

  private

  def find_order
    @order = Order.find_by_token(params[:order_id])
  end

  def invoice_params
    params.require(:invoice).permit(:type, :organization, :person_name, :identity_no, :company_name, :taxpayer_no, :receiver_email,
                                    :receiver_name, :receiver_mobile, :receiver_province, :receiver_city, :receiver_address,
                                    :register_address, :register_phone, :deposit_bank, :bank_no)
  end
end
