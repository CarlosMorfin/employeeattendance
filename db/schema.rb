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

ActiveRecord::Schema.define(version: 2019_08_27_044859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance", force: :cascade do |t|
    t.datetime "check_in", null: false
    t.datetime "check_out"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendance_on_employee_id"
  end

  create_table "employee", force: :cascade do |t|
    t.string "code", limit: 32, null: false
    t.string "name", limit: 64, null: false
    t.string "last_names", limit: 64, null: false
    t.string "gender", limit: 1, null: false
    t.string "email", limit: 128, null: false
    t.string "phone", limit: 32
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_employee_on_code", unique: true
    t.index ["name"], name: "index_employee_on_name"
  end

  create_table "role", force: :cascade do |t|
    t.string "code", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_role_on_code", unique: true
  end

  create_table "role_user", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.index ["role_id", "user_id"], name: "index_role_user_on_role_id_and_user_id"
    t.index ["user_id", "role_id"], name: "index_role_user_on_user_id_and_role_id"
  end

  create_table "user", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.index ["email"], name: "index_user_on_email", unique: true
    t.index ["employee_id"], name: "index_user_on_employee_id"
    t.index ["reset_password_token"], name: "index_user_on_reset_password_token", unique: true
  end

  add_foreign_key "attendance", "employee", on_delete: :cascade
  add_foreign_key "user", "employee", on_delete: :cascade
end
