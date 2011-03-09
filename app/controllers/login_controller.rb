class LoginController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to '/landing.html'
    else
      flash.now[:alert] = "The email and password combination was incorrect.  Please re-enter the information."
      render "new"
      user = nil
    end
  end
  
  def destroy
  end
end
