class Admin::LogsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @logs = Log.all
  end
end
