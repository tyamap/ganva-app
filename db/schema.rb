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

ActiveRecord::Schema.define(version: 2020_03_18_120229) do

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

  create_table "records", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "type", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.string "where", null: false
    t.string "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_records_on_activity_id"
    t.index ["type", "activity_id"], name: "index_records_on_type_and_activity_id"
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
    t.string "name", default: "", null: false
    t.string "experience", default: "", null: false
    t.string "frequency", default: "", null: false
    t.string "level", default: "", null: false
    t.string "introduction", default: "", null: false
    t.string "status", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_users_on_LOWER_email", unique: true
    t.index "lower((uid)::text)", name: "index_users_on_LOWER_uid", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "records", "activities"
end
