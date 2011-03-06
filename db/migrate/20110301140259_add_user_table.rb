class AddUserTable < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :name, :optional => false
      t.string    :display_name, :optional => false
      t.boolean   :deleted, :default => false
      t.string    :hashed_password, :optional => false
      t.string    :salt, :optional => false
      t.timestamps
    end
    
    create_table :services do |t|
      t.integer   :user_id, :optional => false
      t.integer   :service_type, :optional => false
      t.string    :service_uname, :optional => false
      t.string    :service_pwd, :optional => false
      t.timestamps
    end
  end

  def self.down
    drop_table :services
    drop_table :users
  end
end
