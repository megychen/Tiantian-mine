class Admin::LogsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @logs = Log.paginate(:page => params[:page], :per_page => 20)
  end
end
