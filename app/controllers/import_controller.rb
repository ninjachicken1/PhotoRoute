require 'flickr_fu'

class ImportController < AuthenticatedController
  def show
    @photos = []
    @service = Service.find_by_user_id_and_service_type(current_user.id, Service::FLICKR)
    create_flickr_client
    
    # Retrieve list of new photos from Flickr
    @photos = @flickr.photos.search(:user_id => @service.service_user_id, :tags => 'route')
    
    # Include user's paths for choosing a Path to import photos to
    @paths = Path.find_all_by_user_id(current_user.id, :select => "id, name")
  end
  
  def create
    checks = params.select {|k,v| k.start_with?('photo_')}
    if checks
      @service = Service.find_by_user_id_and_service_type(current_user.id, Service::FLICKR)
      create_flickr_client
      
      checks.each do |check|
        # Retrieve Photo and EXIF info - save as waypoint
        photo_id = check[1]
        search = Flickr::Photos.new(@flickr)
        begin
          photo = search.find_by_id(photo_id)
          geo_lookup = Flickr::Photos::Geo.new(@flickr)
          geo = geo_lookup.get_location(photo_id)
          
          path = Path.find(params[:path_id])
          
          # Create a new Waypoint
          w = Waypoint.new
          w.user = current_user
          w.source_image_urn = photo.url
          w.image_urn = "tempuri.org/#{photo.id}"
          w.latlng = "#{geo.latitude},#{geo.longitude}"
          w.taken = photo.taken_at
          w.save!
          
          # Assign the waypoint to the selected path
          pp = PathWaypoint.new
          pp.path = path
          pp.waypoint = w
          pp.seq = 1
          pp.save!
        rescue Exception => ex
          logger.error "An exception occurred retrieving photo and geo info for photo '#{photo_id}' and user '#{current_user.id}': #{ex.message}\n #{ex.backtrace}"
          flash[:error] = "An error occurred importing the selected photos.  Some of your photos may not have been imported."
          redirect_to "show"
          break
        end
        break if flash[:error]
      end
    end
  end
  
  # Accept the user's authorization of our PhotoROUTE Flickr API application
  def flickr_token
    create_flickr_client
    @flickr.auth.frob = params[:frob]
    
    # Create or Update the Flickr service 
    service = Service.find_by_user_id_and_service_type(current_user.id, Service::FLICKR)
    if service
      service = Service.new
    end
    service.user = current_user
    service.service_type = Service::FLICKR
    service.service_user = @token.user_real_name
    service.service_uname = @token.username
    service.service_user_id = @token.user_id
    service.service_pwd = nil
    service.service_token = flickr.auth.token.token
    
    debugger
    begin
      flash[:notice] = "Your Flickr account was validated.  Any of your photos tagged with 'route' are available."
      @service = service.save
    rescue
      flash[:warning] = "Your Flickr account could not be validated at this time.  Please try again later."
      logger.error "An exception occurred saving the service '#{service.id}' for user '(#{current_user.id}) current_user.name'."
    end

    redirct_to "show"
  end
  
  private
  
  def create_flickr_client
    token = nil
    token = @service.service_token if @service
    
    a = {}
    a[:key] = $flickr_config[:key]
    a[:secret] = $flickr_config[:secret]
    a[:token] = token
    @flickr = Flickr.new(a)
    #@flickr = Flickr.new(File.dirname(__FILE__) + '/../../config/flickr.yml')
    @flickr
  end
end