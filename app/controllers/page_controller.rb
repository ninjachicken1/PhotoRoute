class PageController < AuthenticatedController
  def show
    
    respond_to do |format|
      format.html { 
        if params[:name]
          render "#{params[:name].downcase}"
        else
          render :status => "404"
        end
      }
    end
  end
end
