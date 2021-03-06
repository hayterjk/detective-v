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

ActiveRecord::Schema.define(version: 20161002164430) do

  create_table "issues", force: :cascade do |t|
    t.integer  "severity"
    t.string   "source"
    t.string   "description"
    t.text     "detail"
    t.string   "fingerprint"
    t.integer  "scan_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "repo_id"
    t.string   "scanner"
    t.string   "file"
    t.string   "line"
    t.string   "code"
    t.integer  "user_id"
  end

  add_index "issues", ["repo_id"], name: "index_issues_on_repo_id"
  add_index "issues", ["scan_id"], name: "index_issues_on_scan_id"

  create_table "repos", force: :cascade do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "html_url"
    t.string   "description"
    t.string   "language"
    t.integer  "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "repos", ["user_id"], name: "index_repos_on_user_id"

  create_table "scans", force: :cascade do |t|
    t.string   "status"
    t.integer  "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "scans", ["repo_id"], name: "index_scans_on_repo_id"

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
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "access_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
