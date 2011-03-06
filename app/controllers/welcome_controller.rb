class WelcomeController < ApplicationController
  
  # GET /
  # GET /welcome
  def index    
    respond_to do |format|
      format.html
    end
  end
  
end
