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

ActiveRecord::Schema.define(version: 20160605194616) do

  create_table "dependencies", force: true do |t|
    t.string   "file_name"
    t.string   "file_path"
    t.string   "md5"
    t.string   "sha1"
    t.integer  "num_evidence"
    t.text     "descriptions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "repository_id"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", force: true do |t|
    t.string   "url"
    t.string   "owner"
    t.string   "email"
    t.date     "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "userpath"
    t.string   "repopath"
    t.integer  "user_id"
    t.integer  "organization_id"
  end

  add_index "repositories", ["organization_id"], name: "index_repositories_on_organization_id"

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_organizations", force: true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  create_table "vulnerabilities", force: true do |t|
    t.string   "cve_name"
    t.decimal  "cvss_score"
    t.string   "cav"
    t.string   "cac"
    t.string   "ca"
    t.string   "cci"
    t.string   "cai"
    t.string   "cii"
    t.string   "severity"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
  end

end
