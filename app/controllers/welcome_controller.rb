class WelcomeController < ApplicationController
  
  # GET /
  # GET /welcome
  def index    
    respond_to do |format|
      format.html { render :template => "welcome/welcome.html.erb", :layout => false }
    end
  end
  
end
