class UsersController < ApplicationController
  # GET /admin/users
  def index
    respond_to do |format|
      format.html  #index.haml
    end
  end

  # GET /admin/users/1
  def show
    respond_to do |format|
      format.html  #show.haml
    end
  end

  # GET /admin/users/new
  def new
  end
  
  # POST /admin/users
  def create
  end

  # GET /admin/users/1/edit
  def edit
  end
  
  # PUT /admin/users/1
  def update
  end
  
  # DELETE /admin/users/1
  def destroy
  end
  
private
end