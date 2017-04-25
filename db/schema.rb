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

ActiveRecord::Schema.define(version: 20170425133540) do

  create_table "automations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "browser_type"
    t.integer  "user_id"
    t.datetime "execute_at"
    t.integer  "repetition"
    t.integer  "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.string  "color",    default: "#000000"
    t.integer "priority", default: 0
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",      default: 0, null: false
    t.integer  "attempts",      default: 0, null: false
    t.text     "handler",                   null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "automation_id"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "logs", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "automation_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.integer "automation_id"
    t.integer "position"
    t.boolean "broken"
    t.integer "category"
    t.integer "selector"
    t.string  "path"
    t.integer "action"
    t.string  "input"
    t.integer "fill_into"
    t.string  "name"
  end

  create_table "users", force: :cascade do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
