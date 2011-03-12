ActionController::Routing::Routes.draw do |map|
  # Authentication (mixture of public and authenticated paths)
  map.logout '/logout', :controller => 'login', :action => 'destroy', :conditions => { :method => :get }
  map.resource 'login', :only => [:new, :create], :path_names => { :new => '' }, :controller => 'login'
  map.resources 'subscribers', :except => :index

  # Authenticated pages
  map.resources :points, :controller => 'waypoints'
  map.resources :paths do |paths|
    paths.resources :points, :controller => 'pathwaypoints'
  end
  map.conenct '/import', :controller => 'import', :action => 'show', :conditions => { :method => :get }
  map.conenct '/import', :controller => 'import', :action => 'create', :conditions => { :method => :post }
  map.connect '/import/token', :controller => 'import', :action => 'flickr_token', :conditions => { :method => :get }

  # Admin-only pages
  map.namespace :admin do |admin|
    admin.resources :users
  end

  # Unauthenticated pages
  map.page '/page/:name', :controller => 'page', :action => 'show', :conditions => { :method => :get }
  map.welcome '/welcome', :controller => 'welcome', :action => 'index', :conditions => { :method => :get }
  map.root :welcome
end
