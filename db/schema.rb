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

ActiveRecord::Schema.define(version: 2020_03_24_133759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "date", null: false
    t.string "title", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date", "user_id"], name: "index_activities_on_date_and_user_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "commit_records", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.string "where", null: false
    t.string "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_commit_records_on_activity_id"
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "address", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "result_records", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.string "where", null: false
    t.integer "cnt_vb", default: 0, null: false
    t.integer "cnt_v0", default: 0, null: false
    t.integer "cnt_v1", default: 0, null: false
    t.integer "cnt_v2", default: 0, null: false
    t.integer "cnt_v3", default: 0, null: false
    t.integer "cnt_v4", default: 0, null: false
    t.integer "cnt_v5", default: 0, null: false
    t.integer "cnt_v6", default: 0, null: false
    t.integer "cnt_v7", default: 0, null: false
    t.integer "cnt_v8plus", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_result_records_on_activity_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "uid", null: false
    t.string "name", default: "", null: false
    t.string "experience", default: "未設定", null: false
    t.string "frequency", default: "未設定", null: false
    t.string "level", default: "未設定", null: false
    t.string "introduction", default: "未設定", null: false
    t.string "status", default: "未設定", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_users_on_LOWER_email", unique: true
    t.index "lower((uid)::text)", name: "index_users_on_LOWER_uid", unique: true
  end

  add_foreign_key "activities", "users"
end
