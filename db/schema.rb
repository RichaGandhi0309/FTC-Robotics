# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131208030203) do

  create_table "event_registration", :force => true do |t|
    t.string "event_name"
    t.string "team_no"
    t.string "event_category"
  end

  create_table "events", :force => true do |t|
    t.datetime "eventdate"
    t.string   "eventdesp"
    t.string   "teamsregistered"
    t.string   "eventlocation"
    t.string   "eventscope"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "league_name"
    t.string   "team_no"
    t.string   "league_admin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "teams", :force => true do |t|
    t.integer  "team"
    t.text     "organization"
    t.string   "city"
    t.string   "state"
    t.datetime "date_registered"
    t.string   "main_contact"
    t.string   "main_contact_address"
    t.string   "main_contact_city"
    t.string   "main_contact_state"
    t.string   "main_contact_postal_code"
    t.string   "country"
    t.string   "main_contact_email"
    t.string   "main_contact_phone"
    t.string   "county"
    t.string   "school_district"
    t.string   "organization_type"
    t.string   "league_name"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_id"
    t.string   "email"
    t.string   "role"
    t.string   "password"
    t.string   "session_token"
    t.string   "updatedProfile"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
