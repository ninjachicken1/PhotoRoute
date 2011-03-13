class WelcomeController < ApplicationController
  
  # GET /
  # GET /welcome
  def index      
    respond_to do |format|
      if session[:user_id]
        format.html { redirect_to paths_path if session[:user_id] }
      else        
        format.html { render :template => "welcome/welcome.html.erb", :layout => false }
      end
    end
  end
  
end
