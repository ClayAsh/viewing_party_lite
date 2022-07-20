class Admin::DashboardController < ApplicationController 
  before_action :require_admin

  def index 
    @user = User.find(current_user.id)
  end

  private 
  def require_admin 
    if !current_user.admin?
      redirect_to root_path 
      flash[:error] = "The page you are trying to view cannot be found."
    end 
  end
end