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

ActiveRecord::Schema.define(version: 20160804020855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "containers", force: :cascade do |t|
    t.string   "name"
    t.string   "size"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active",     default: true
  end

  create_table "diet_restrictions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diet_restrictions_groups", id: false, force: :cascade do |t|
    t.integer "group_id",            null: false
    t.integer "diet_restriction_id", null: false
  end

  create_table "diet_restrictions_users", id: false, force: :cascade do |t|
    t.integer "user_id",             null: false
    t.integer "diet_restriction_id", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_participants", default: 1
    t.decimal  "budget"
    t.string   "container_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "swap_location"
    t.integer  "container_id"
    t.integer  "admin"
  end

  add_index "groups", ["container_id"], name: "index_groups_on_container_id", using: :btree

  create_table "meal_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_ratings", force: :cascade do |t|
    t.integer  "rating"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "meal_id"
  end

  add_index "meal_ratings", ["meal_id"], name: "index_meal_ratings_on_meal_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.date     "shop_date"
    t.date     "cook_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "week_id"
    t.integer  "meal_category_id"
    t.string   "cooking_time"
    t.string   "cooking_degrees"
    t.boolean  "covered"
    t.string   "timing_to_eat"
    t.boolean  "freezable"
  end

  add_index "meals", ["meal_category_id"], name: "index_meals_on_meal_category_id", using: :btree
  add_index "meals", ["user_id"], name: "index_meals_on_user_id", using: :btree
  add_index "meals", ["week_id"], name: "index_meals_on_week_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "group_id",       null: false
    t.string   "status"
    t.string   "invite_token"
    t.datetime "invite_sent_at"
  end

  add_index "members", ["group_id", "user_id"], name: "index_members_on_group_id_and_user_id", using: :btree
  add_index "members", ["user_id", "group_id"], name: "index_members_on_user_id_and_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "cooking_level"
    t.string   "name"
    t.integer  "zip_code"
    t.string   "city"
    t.boolean  "temporary",              default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weeks", force: :cascade do |t|
    t.date     "swap_date"
    t.date     "start_date"
    t.string   "swap_location"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "group_id"
  end

  add_index "weeks", ["group_id"], name: "index_weeks_on_group_id", using: :btree

  add_foreign_key "groups", "containers"
  add_foreign_key "meal_ratings", "meals"
  add_foreign_key "meals", "meal_categories"
  add_foreign_key "meals", "users"
  add_foreign_key "meals", "weeks"
  add_foreign_key "weeks", "groups"
end
