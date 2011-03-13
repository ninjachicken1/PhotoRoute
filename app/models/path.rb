class Path < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :path_waypoints, :dependent => :destroy
  has_many :waypoint, :through => :path_waypoints, :dependent => :destroy
  
  validates_presence_of :name, :path_type
end