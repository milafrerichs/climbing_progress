# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_26_172830) do
  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_areas_on_location_id"
  end

  create_table "climb_logs", force: :cascade do |t|
    t.date "date"
    t.string "route_name"
    t.decimal "grade"
    t.string "status"
    t.text "notes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tries"
    t.integer "climb_type"
    t.integer "location_id"
    t.integer "climb_session_id"
    t.index ["climb_session_id"], name: "index_climb_logs_on_climb_session_id"
    t.index ["location_id"], name: "index_climb_logs_on_location_id"
    t.index ["user_id"], name: "index_climb_logs_on_user_id"
  end

  create_table "climb_sessions", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "end"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["location_id"], name: "index_climb_sessions_on_location_id"
    t.index ["user_id"], name: "index_climb_sessions_on_user_id"
  end

  create_table "location_areas", force: :cascade do |t|
    t.string "name"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_areas_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "end"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_sessions_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "areas", "locations"
  add_foreign_key "climb_logs", "climb_sessions"
  add_foreign_key "climb_logs", "locations"
  add_foreign_key "climb_logs", "users"
  add_foreign_key "climb_sessions", "locations"
  add_foreign_key "climb_sessions", "users"
  add_foreign_key "location_areas", "locations"
  add_foreign_key "sessions", "locations"
end
