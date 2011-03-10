class LoginController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to(:controller => "/paths")
    else
      flash.now[:alert] = "The email and password combination was incorrect.  Please re-enter the information."
      render "new"
      user = nil
    end
  end
  
  def destroy
    @current_user = nil
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to :controller => "/welcome"
  end
end
