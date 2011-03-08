class CreatePathsWaypointsJoins < ActiveRecord::Migration
  def self.up    
    create_table :paths do |t|
      t.integer   :user_id, :nullable => false
      t.string    :name, :nullable => false
      t.string    :description, :default => '', :nullable => false
      t.string    :image_urn, :default => '', :nullable => false
      t.string    :path_type, :nullable => false
      t.string    :duration
      t.timestamps
    end
    
    create_table :waypoints do |t|
      t.integer   :user_id, :nullable => false
      t.string    :source_image_urn
      t.string    :image_urn
      t.string    :latlng
      t.datetime  :taken
      t.timestamps
    end
    
    create_table :path_waypoints do |t|
      t.integer   :path_id
      t.integer   :waypoint_id
      t.float     :order
      t.timestamps
    end
  end
  
  def self.down
    drop_table :path_waypoints
    drop_table :waypoints
    drop_table :paths
  end
end
