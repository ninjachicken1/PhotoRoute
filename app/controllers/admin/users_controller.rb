require File.dirname(__FILE__) + '/../../models/users'

module Admin
  class UsersController < ApplicationController
    # GET /admin/users
    def index
      @users = User.all
      
      respond_to do |format|
        format.html  # index.haml
      end
    end

    # GET /admin/users/1
    def show
      @user = User.find(params[:id])
      respond_to do |format|
        format.html  # show.haml
      end
    end

    # GET /admin/users/new
    def new
      @user = User.new
      respond_to do |format|
        format.html  # new.haml
      end
    end

    # POST /admin/users
    def create
      @user = User.new(params[:user])
      
      respond_to do |format|
        if @user.save
          flash[:notice] = "User #{@user.name} was successfully created."
          format.html { redirect_to(:controller => 'users', :action => 'index') }
        else
          flash[:warning] = "An error occurred trying to save the user 'params[:user][:name]', please try again."
        end
      end
    end

    # GET /admin/users/1/edit
    def edit
      @user = User.find(params[:id])
      respond_to do |format|
        format.html   # admin/users/edit.haml
      end
    end
  
    # PUT /admin/users/1
    def update
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash[:notice] = "Successfully updated user '#{@user.name}'."
          format.html { redirect_to :action => 'index' }
        else
          flash[:warning] = "An error occurred trying to save the user 'params[:user][:name]', please try again."
        end
      end
    end
  
    # DELETE /admin/users/1
    def destroy
      notice = ''
      id = params[:id]
      user = User.find(id)
      
      if user.blank?
        notice = "Could not locate a user with id '#{id}'"
      else
        begin
          User.destroy(id)
          notice = "User '#{user.name}' deleted."
        rescue Exception => e
          logger.error "Could not delete the specified user: " + e.message
          notice = "Could not delete the specified user: " + e.message
        end
      end

      flash[:notice] = notice
      respond_to do |format|
        format.html { redirect_to(:controller => 'users', :action => 'index') }
      end      
    end
  
private
  end
end