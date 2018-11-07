class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user

    if @address.save
      if request.xhr? || request.format.js?
        render :json => { "success": true }
      else
        redirect_to addresses_path
      end
    else
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  def load_address_list
    render :partial => "carts/_address"
  end

  private

  def address_params
    params.require(:address).permit(:name, :mobile, :zip_code, :detail, :province, :city, :district)
  end
end
