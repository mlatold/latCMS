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

ActiveRecord::Schema.define(version: 20140930211520) do

  create_table "admin_users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "user_secret"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["user_secret"], name: "index_admin_users_on_user_secret"

  create_table "brute_forces", force: true do |t|
    t.string   "remote_ip"
    t.integer  "counter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brute_forces", ["remote_ip"], name: "index_brute_forces_on_remote_ip"

  create_table "pages", force: true do |t|
    t.string   "route"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["route"], name: "index_pages_on_route", unique: true

end
