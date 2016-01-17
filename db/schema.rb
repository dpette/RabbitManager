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

ActiveRecord::Schema.define(version: 20160117002746) do

  create_table "cages", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "farm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  create_table "compartments", force: :cascade do |t|
    t.integer  "code"
    t.integer  "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cage_id"
  end

  create_table "farms", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rabbits", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.boolean  "race"
    t.date     "birth_date"
    t.date     "death_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stayings", force: :cascade do |t|
    t.integer  "rabbit_id"
    t.integer  "compartment_id"
    t.datetime "starting_at"
    t.datetime "ending_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "cage_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weights", force: :cascade do |t|
    t.float    "value"
    t.datetime "registered_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
