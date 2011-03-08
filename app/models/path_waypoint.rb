class PathWaypoint < ActiveRecord::Base
  # Associations
  belongs_to :path
  belongs_to :waypoint
  
end
