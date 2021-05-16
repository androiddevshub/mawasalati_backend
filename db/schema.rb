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

ActiveRecord::Schema.define(version: 2021_04_18_094903) do

  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "scheduled_bus_id", null: false
    t.bigint "user_id", null: false
    t.string "booking_id"
    t.string "date"
    t.decimal "tax_fare", precision: 10, scale: 2
    t.decimal "passenger_fare", precision: 10, scale: 2
    t.decimal "total_fare", precision: 10, scale: 2
    t.string "email"
    t.string "phone"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scheduled_bus_id"], name: "index_bookings_on_scheduled_bus_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "buses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "bus_type"
    t.string "operator_contact_first"
    t.string "operator_contact_second"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "passengers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.string "name"
    t.string "age"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
  end

  create_table "scheduled_buses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "bus_id", null: false
    t.string "bus_number"
    t.string "origin"
    t.string "destination"
    t.string "departure_center"
    t.string "arrival_center"
    t.string "departure_time"
    t.string "arrival_time"
    t.string "duration"
    t.integer "seats"
    t.string "departure_date"
    t.string "arrival_date"
    t.integer "price"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bus_id"], name: "index_scheduled_buses_on_bus_id"
  end

  create_table "user_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "access_token"
    t.datetime "expires_at"
    t.integer "user_id"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token"], name: "index_user_tokens_on_access_token", unique: true
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.boolean "admin", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "scheduled_buses"
  add_foreign_key "bookings", "users"
  add_foreign_key "passengers", "bookings"
  add_foreign_key "scheduled_buses", "buses"
end
