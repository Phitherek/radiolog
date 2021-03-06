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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150922183919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "regular_log_entries", force: :cascade do |t|
    t.integer  "remote_user_id",                        null: false
    t.string   "to_callsign",                           null: false
    t.string   "rst_from"
    t.string   "rst_to",                                null: false
    t.string   "name"
    t.string   "qth"
    t.string   "qth_locator"
    t.datetime "utc"
    t.string   "notes"
    t.string   "freq"
    t.string   "mod"
    t.string   "via"
    t.string   "mode",                                  null: false
    t.string   "qsl",            default: "impossible", null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "remote_sessions", force: :cascade do |t|
    t.string   "token"
    t.datetime "token_expires"
    t.string   "refresh_token"
    t.integer  "remote_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "remote_users", force: :cascade do |t|
    t.string   "callsign"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
