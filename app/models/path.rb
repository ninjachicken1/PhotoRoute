class Path < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :waypoint, :through => :path_waypoint, :dependent => :destroy
  
  validates_uniqueness_of :name
  validates_presence_of :name, :path_type
end