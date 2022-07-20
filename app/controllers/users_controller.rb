class UsersController < ApplicationController

  def index

  end

  def new
    @user_new = User.new
  end

  def show
    if current_user
    @user = User.find(current_user.id)
    else  
      flash[:error] = "You must be logged in to view the dashboard."
      redirect_to root_path 
    end 
  end

  def create
    user = User.new(user_params)
    if user.save 
      session[:user_id] = user.id 
      redirect_to dashboard_path
      flash[:success] = "Welcome #{user.name}!"
    else  
      redirect_to registration_path
      flash[:error] = user.errors.full_messages
    end 
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

