# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110308144647) do

  create_table "path_waypoints", :force => true do |t|
    t.integer  "path_id"
    t.integer  "waypoint_id"
    t.float    "seq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paths", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description", :default => ""
    t.string   "image_urn",   :default => ""
    t.string   "path_type"
    t.string   "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_type"
    t.string   "service_uname"
    t.string   "service_pwd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.boolean  "deleted",         :default => false
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "waypoints", :force => true do |t|
    t.integer  "user_id"
    t.string   "source_image_urn"
    t.string   "image_urn"
    t.string   "latlng"
    t.datetime "taken"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
