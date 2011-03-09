class SubscribersController < ApplicationController
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.display_name = @user.name
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to '/landing.html' }
      else
        flash.now[:warning] = "An error occurred trying to save the user '#{params[:user][:name]}', please try again."
      end
    end
  end
  
  def edit
  end
  
  def udpate
  end
  
  def destroy
  end
end
