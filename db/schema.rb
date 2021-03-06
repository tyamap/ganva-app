# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_25_130600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.bigint "gym_id", null: false
    t.string "level"
    t.string "status", default: "ready", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date", "user_id"], name: "index_activities_on_date_and_user_id"
    t.index ["gym_id"], name: "index_activities_on_gym_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name", null: false
    t.string "postal_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "address1", null: false
    t.string "address2", null: false
    t.text "introduction", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "level_counts", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.integer "level0", default: 0, null: false
    t.integer "level1", default: 0, null: false
    t.integer "level2", default: 0, null: false
    t.integer "level3", default: 0, null: false
    t.integer "level4", default: 0, null: false
    t.integer "level5", default: 0, null: false
    t.integer "level6", default: 0, null: false
    t.integer "level7", default: 0, null: false
    t.integer "level8", default: 0, null: false
    t.integer "level9", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_level_counts_on_activity_id"
  end

  create_table "level_names", force: :cascade do |t|
    t.bigint "gym_id", null: false
    t.string "level0", default: "レベル1"
    t.string "level1", default: "レベル2"
    t.string "level2", default: "レベル3"
    t.string "level3", default: "レベル4"
    t.string "level4", default: "レベル5"
    t.string "level5", default: "レベル6"
    t.string "level6", default: "レベル7"
    t.string "level7", default: "レベル8"
    t.string "level8", default: "レベル9"
    t.string "level9", default: "レベル10"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gym_id"], name: "index_level_names_on_gym_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.bigint "gym_id"
    t.string "experience"
    t.string "frequency"
    t.string "level"
    t.string "introduction"
    t.string "status", default: "stable", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_users_on_LOWER_email", unique: true
    t.index "lower((uid)::text)", name: "index_users_on_LOWER_uid", unique: true
    t.index ["gym_id"], name: "index_users_on_gym_id"
  end

  add_foreign_key "activities", "gyms"
  add_foreign_key "activities", "users"
  add_foreign_key "users", "gyms"
end
