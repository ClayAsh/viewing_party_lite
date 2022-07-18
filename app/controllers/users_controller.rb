class UsersController < ApplicationController

  def index

  end

  def new
    @user_new = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save 
      redirect_to "/users/#{user.id}"
      flash[:success] = "Welcome #{user.name}!"
    else  
      redirect_to '/registration'
      flash[:error] = user.errors.full_messages
    end 
  end

  def login_form 
  end

  def login_user 
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      redirect_to "/users/#{user.id}"
      flash[:success] = "Welcome back #{user.name}!"
    else 
      redirect_to '/login'
      flash[:error] = "Invalid Credentials"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

