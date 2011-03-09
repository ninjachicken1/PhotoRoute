class Waypoint < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :path_waypoints
  has_many :path, :through => :path_waypoints, :dependent => :destroy
  
  validates_presence_of :source_image_urn, :image_urn, :latlng, :taken
  
end
