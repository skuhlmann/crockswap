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

ActiveRecord::Schema.define(version: 20161202224947) do

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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "container_id"
    t.integer  "admin"
    t.boolean  "leaderboard",      default: false
    t.index ["container_id"], name: "index_groups_on_container_id", using: :btree
  end

  create_table "meal_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "week_id"
    t.integer  "meal_category_id"
    t.string   "recipe_url"
    t.string   "instructions"
    t.string   "accompaniments"
    t.index ["meal_category_id"], name: "index_meals_on_meal_category_id", using: :btree
    t.index ["user_id"], name: "index_meals_on_user_id", using: :btree
    t.index ["week_id"], name: "index_meals_on_week_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "group_id",       null: false
    t.string   "status"
    t.string   "invite_token"
    t.datetime "invite_sent_at"
    t.index ["group_id", "user_id"], name: "index_members_on_group_id_and_user_id", using: :btree
    t.index ["user_id", "group_id"], name: "index_members_on_user_id_and_group_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.string   "feedback"
    t.integer  "user_id"
    t.integer  "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_reviews_on_meal_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
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
    t.string   "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weeks", force: :cascade do |t|
    t.date     "swap_date"
    t.date     "start_date"
    t.string   "swap_location"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "group_id"
    t.boolean  "paused",        default: false
    t.string   "swap_time"
    t.index ["group_id"], name: "index_weeks_on_group_id", using: :btree
  end

  add_foreign_key "groups", "containers"
  add_foreign_key "meals", "meal_categories"
  add_foreign_key "meals", "users"
  add_foreign_key "meals", "weeks"
  add_foreign_key "weeks", "groups"
end
