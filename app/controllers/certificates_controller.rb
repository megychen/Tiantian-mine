class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order

  def index
    @certificates = @order.certificates
  end

  def show
    @certificate = @order.certificates.find(params[:id])
  end

  def new
    @certificate = Certificate.new
    @photos = @certificate.photos.build
  end

  def create
    @certificate = Certificate.new(certificate_params)
    @certificate.order = @order

    if @certificate.save
      if params[:photos] != nil
        params[:photos]['image'].each do |i|
          @phots = @certificate.photos.create(:image => i)
        end
      end
      redirect_to order_certificates_path(@order.token)
    else
      render :new
    end
  end

  def edit
    @certificate = @order.certificates.find(params[:id])
  end

  def update
    @certificate = @order.certificates.find(params[:id])

    if params[:photos] != nil
      @certificate.photos.destroy_all
      params[:photos]['image'].each do |i|
        @phots = @certificate.photos.create(:image => i)
      end
      @certificate.update(certificate_params)

      redirect_to order_certificates_path(@order.token)
    elsif @certificate.update(certificate_params)
      redirect_to order_certificates_path(@order.token)
    else
      render :edit
    end
  end

  def destroy
    @certificate = @order.certificates.find(params[:id])
    @certificate.destroy
    @certificate.photos.destroy

    redirect_to order_certificates_path(@order.token)
  end

  private

  def find_order
    @order = Order.find_by_token(params[:order_id])
  end

  def certificate_params
    params.require(:certificate).permit(:name, :amount, :image)
  end
end
