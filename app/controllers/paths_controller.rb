class PathsController < AuthenticatedController
  def index
    @paths = Path.find_all_by_user_id(current_user.id)
  end
  
  def show
    @path = Path.find_by_id_and_user_id(params[:id], current_user.id)
    if @path
      respond_to do |format|
        format.html
      end
    else
      repond_to do |format|
        format.html {
          flash[:error] = "Could not find the path '#{params[:id]}'."
          redirect_to paths_path
        }
      end
    end
  end
  
  def new
    @path = Path.new
    @path.user = current_user
  end
  
  def create
    @path = Path.new(params[:path])
    @path.user = current_user
    @path.image_urn = "tempuri.org/image/123"
    @path.path_type = "commute"
    if @path.save
      flash[:notice] = "Created path '#{@path.name}'."
      redirect_to '/paths'
    else
      flash[:error] = "Could not create path '#{@path.name}'."
      render "new"
    end
  end
  
  def edit
    @path = Path.find_by_id_and_user_id(params[:id], current_user.id)
    if @path.blank?
      flash[:error] = "Could not retrieve the specified path."
      redirect_to paths_url
    end
  end
  
  def update
    @path = Path.find_by_id_and_user_id(params[:id], current_user.id)
    respond_to do |format|
      if @path.update_attributes(params[:path])
        flash[:notice] = "Updated path '#{@path.name}'."
        format.html { redirect_to paths_path }
      else
        flash.now[:error] = "An error occurred updating the path with id '#{params[:id]}'."
        format.html { render "edit" }
      end
    end
  end
  
  def destroy
    path = Path.find_by_id_and_user_id(params[:id], current_user.id)
    name = path.name
    if path.destroy
      flash[:notice] = "Deleted path '#{name}'."
      redirect_to paths_path
    else
      flash[:error] = "Could not delete the path '#{name}'.  Please try again."
      redirect_to paths_path
    end
  end
end
