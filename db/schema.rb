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

ActiveRecord::Schema.define(version: 20160821194032) do

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "client_id"
    t.string   "name"
    t.string   "surname_1"
    t.string   "surname_2"
    t.string   "dni_passport"
    t.string   "genre"
    t.date     "birthday"
    t.string   "country"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "job_position"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "centers", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "center_name"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "zip_code"
    t.string   "country"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "fax_number"
    t.string   "email"
    t.string   "language"
    t.string   "currency"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "centers_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "center_id"
  end

  add_index "centers_users", ["center_id"], name: "index_centers_users_on_center_id"
  add_index "centers_users", ["user_id"], name: "index_centers_users_on_user_id"

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "clinic_name"
    t.string   "nif"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "zip_code"
    t.string   "country"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "fax_number"
    t.string   "email"
    t.string   "language"
    t.string   "currency"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "patient_id"
    t.string   "patient_name"
    t.string   "patient_surname"
    t.string   "observation"
    t.string   "reason"
    t.date     "date"
    t.time     "hour_minute"
    t.time     "start_time"
    t.integer  "wait_time"
    t.integer  "visit_time"
    t.integer  "total_time"
    t.time     "finish_time"
    t.string   "doctor_name"
    t.string   "doctor_surname"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "client_id"
    t.string   "name"
    t.string   "surname_1"
    t.string   "surname_2"
    t.string   "dni_passport"
    t.string   "genre"
    t.date     "birthday"
    t.string   "country"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "job_position"
    t.boolean  "is_admin?",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
