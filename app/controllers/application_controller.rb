class ApplicationController < ActionController::Base
  helper_method :current_user, :default?, :admin? 

  def current_user 
    User.find(session[:user_id]) if session[:user_id]
  end

  def default? 
    current_user && current_user.roll == 0 
  end
  
  def admin? 
    current_user && current_user.roll == 1 
  end

end
