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

ActiveRecord::Schema.define(version: 20151012211932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contacts", ["group_id"], name: "index_contacts_on_group_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "header"
    t.text     "body"
    t.string   "link"
    t.string   "image_url"
    t.datetime "date"
    t.boolean  "sent"
    t.boolean  "scheduled"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "recipient_id"
    t.string   "MediaURL"
  end

  add_index "messages", ["group_id"], name: "index_messages_on_group_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "website"
    t.string   "image_url"
    t.integer  "group_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recipients", ["group_id"], name: "index_recipients_on_group_id", using: :btree
  add_index "recipients", ["message_id"], name: "index_recipients_on_message_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "website"
    t.string   "image_url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "twitter_token"
    t.string   "twitter_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "contacts", "groups"
  add_foreign_key "groups", "users"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "recipients"
  add_foreign_key "recipients", "groups"
  add_foreign_key "recipients", "messages"
end
