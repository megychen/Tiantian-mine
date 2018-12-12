class Admin::UsersController < AdminController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required!

  def index
    @users = User.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:remark)
  end
end
