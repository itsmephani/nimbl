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

ActiveRecord::Schema.define(version: 20150412072659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.string  "keyword"
    t.decimal "results_count"
    t.decimal "time_taken"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "no_of_adwords_top"
    t.integer "no_of_adwords_right"
    t.integer "no_of_non_adwords_results"
    t.integer "total_results_per_page"
    t.integer "start"
    t.text    "content"
    t.integer "keyword_id"
  end

  create_table "results", force: :cascade do |t|
    t.string  "link"
    t.string  "display_url"
    t.boolean "is_ad",       default: false
    t.integer "page_id"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
