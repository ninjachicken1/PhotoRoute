class AuthenticatedController < ActionController::Base
  helper_method :current_user
  
  before_filter :require_login
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this page."
      redirect_to (:controller => '/welcome')
    end
  end
end