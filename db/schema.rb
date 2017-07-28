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

ActiveRecord::Schema.define(version: 20170728141901) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["group_id"], name: "index_activities_on_group_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["profile_id"], name: "index_categories_on_profile_id"

  create_table "expenses", force: :cascade do |t|
    t.date     "exp_date"
    t.decimal  "amt"
    t.integer  "profile_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "expenses", ["item_id"], name: "index_expenses_on_item_id"
  add_index "expenses", ["profile_id"], name: "index_expenses_on_profile_id"

  create_table "gcategories", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gcategories", ["group_id"], name: "index_gcategories_on_group_id"

  create_table "gexpenses", force: :cascade do |t|
    t.date     "paid_on"
    t.decimal  "total_amt"
    t.decimal  "shared_amt"
    t.integer  "profile_id"
    t.integer  "group_id"
    t.integer  "gitem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gexpenses", ["gitem_id"], name: "index_gexpenses_on_gitem_id"
  add_index "gexpenses", ["group_id"], name: "index_gexpenses_on_group_id"
  add_index "gexpenses", ["profile_id"], name: "index_gexpenses_on_profile_id"

  create_table "gitems", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "gcategory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "gitems", ["gcategory_id"], name: "index_gitems_on_gcategory_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id"

  create_table "member_expenses", force: :cascade do |t|
    t.boolean  "paid",          default: false
    t.integer  "gexpense_id"
    t.integer  "membership_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "member_expenses", ["gexpense_id"], name: "index_member_expenses_on_gexpense_id"
  add_index "member_expenses", ["membership_id"], name: "index_member_expenses_on_membership_id"

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "g_admin",     default: false
    t.integer  "profile_id"
    t.integer  "group_id"
    t.datetime "accepted_on"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id"
  add_index "memberships", ["profile_id"], name: "index_memberships_on_profile_id"

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "group_id"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["group_id"], name: "index_messages_on_group_id"
  add_index "messages", ["profile_id"], name: "index_messages_on_profile_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "gender"
    t.string   "nationality"
    t.string   "religion"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "dob"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "schedules", force: :cascade do |t|
    t.date     "date"
    t.time     "start_time"
    t.integer  "activity_id"
    t.integer  "membership_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "schedules", ["activity_id"], name: "index_schedules_on_activity_id"
  add_index "schedules", ["membership_id"], name: "index_schedules_on_membership_id"

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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
