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

ActiveRecord::Schema.define(version: 20140603211232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "guest_meal_choices", force: true do |t|
    t.integer "guest_id"
    t.integer "food_id"
  end

  add_index "guest_meal_choices", ["food_id"], name: "index_guest_meal_choices_on_food_id", using: :btree
  add_index "guest_meal_choices", ["guest_id"], name: "index_guest_meal_choices_on_guest_id", using: :btree

  create_table "guests", force: true do |t|
    t.string  "name"
    t.integer "rsvp_id"
  end

  create_table "meal_choices", force: true do |t|
    t.integer  "rsvp_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meal_choices", ["food_id"], name: "index_meal_choices_on_food_id", using: :btree
  add_index "meal_choices", ["rsvp_id"], name: "index_meal_choices_on_rsvp_id", using: :btree

  create_table "rsvps", force: true do |t|
    t.integer "user_id"
    t.boolean "attending"
    t.integer "number_of_guests"
    t.string  "comments"
    t.string  "meal_preference"
  end

  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "password_digest"
    t.boolean "admin"
    t.integer "max_guests"
    t.string  "auth_token"
  end

end
