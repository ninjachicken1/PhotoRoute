ActionController::Routing::Routes.draw do |map|
  # Authentication (mixture of public and authenticated paths)
  map.logout '/logout', :controller => 'login', :action => 'destroy', :conditions => { :method => :get }
  map.resource 'login', :only => [:new, :create], :path_names => { :new => '' }, :controller => 'login'
  map.resources 'subscribers', :except => [:index]

  # Authenticated pages
  map.resources :points, :controller => 'waypoints'
  map.resources :paths do |paths|
    paths.resources :points, :controller => 'pathwaypoints'
  end

  # Admin-only pages
  map.namespace :admin do |admin|
    admin.resources :users
  end

  map.welcome 'welcome', :controller => 'welcome', :action => 'index', :conditions => { :method => :get }
  map.root :welcome
end

=begin
# Logging in (creating a session) - Singleton
GET     photoroute.net/login          => :new       # form to login
POST    photoroute.net/login          => :create    # authenticate and login from post info
GET     photoroute.net/logout         => :destroy   # logout the current session

# Creating a user object - Plural Resources
GET     photoroute.net/subscribers/new     => :new       # form to create a new user
POST    photorotue.net/subscribers         => :create    # create a new user from post info
DELETE  photoroute.net/subscribers/1       => :destroy   # delete a user and all records
=end