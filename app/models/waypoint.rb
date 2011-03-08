class Waypoint < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :path, :through => :path_waypoint
  
  validates_presence_of :source_image_urn, :image_urn, :latlng, :taken
  
end
