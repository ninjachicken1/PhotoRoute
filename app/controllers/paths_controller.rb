class PathsController < AuthenticatedController
  def index
    @paths = Path.find_all_by_user_id(current_user.id)
  end
  
  def show
  end
  
  def new
    @path = Path.new
    @path.user = current_user
  end
  
  def create
    debugger
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
