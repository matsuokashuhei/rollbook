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

ActiveRecord::Schema.define(version: 20190814163356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_logs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "ip"
    t.string "remote_ip"
    t.string "request_method"
    t.string "fullpath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "age_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_no"
  end

  create_table "bank_accounts", id: :serial, force: :cascade do |t|
    t.string "holder_name"
    t.string "holder_name_kana"
    t.string "bank_id"
    t.string "bank_name"
    t.string "branch_id"
    t.string "branch_name"
    t.string "account_number"
    t.string "status"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "receipt_date"
    t.date "ship_date"
    t.date "begin_date"
    t.boolean "imperfect"
    t.boolean "change_bank"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.integer "timetable_id"
    t.integer "instructor_id"
    t.integer "dance_style_id"
    t.integer "level_id"
    t.integer "age_group_id"
    t.date "open_date"
    t.date "close_date"
    t.text "note"
    t.integer "monthly_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dance_styles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_no"
  end

  create_table "holidays", id: :serial, force: :cascade do |t|
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.string "team"
    t.string "phone"
    t.string "email_pc"
    t.string "email_mobile"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "transportation"
    t.boolean "taxable"
    t.integer "guaranteed_min"
  end

  create_table "lessons", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.date "date"
    t.string "rolls_status"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status"
  end

  create_table "levels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_no"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.string "gender"
    t.date "birth_date"
    t.string "zip"
    t.string "address"
    t.string "phone_mobile"
    t.string "email_pc"
    t.string "email_mobile"
    t.text "note"
    t.date "enter_date"
    t.date "leave_date"
    t.integer "bank_account_id"
    t.string "status"
    t.string "nearby_station"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "phone_land"
    t.string "number"
  end

  create_table "members_courses", id: :serial, force: :cascade do |t|
    t.integer "member_id"
    t.integer "course_id"
    t.date "begin_date"
    t.date "end_date"
    t.text "note"
    t.boolean "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "substitutable", default: true, null: false
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.date "open_date"
    t.date "close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "read_logs", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.integer "read_comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recesses", id: :serial, force: :cascade do |t|
    t.integer "members_course_id"
    t.string "month"
    t.string "status"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "member_id"
    t.string "status"
    t.integer "substitute_roll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lesson_id"], name: "index_rolls_on_lesson_id"
  end

  create_table "schools", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "zip"
    t.string "address"
    t.string "phone"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "open_date"
    t.date "close_date"
  end

  create_table "studios", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "note"
    t.integer "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "open_date"
    t.date "close_date"
  end

  create_table "time_slots", id: :serial, force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", id: :serial, force: :cascade do |t|
    t.integer "studio_id"
    t.integer "weekday"
    t.integer "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "provider"
    t.string "sub"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "sub"], name: "index_user_authentications_on_provider_and_sub", unique: true
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "role"
    t.string "status"
    t.integer "school_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_logs", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "courses", "age_groups"
  add_foreign_key "courses", "dance_styles"
  add_foreign_key "courses", "instructors"
  add_foreign_key "courses", "levels"
  add_foreign_key "courses", "timetables"
  add_foreign_key "lessons", "courses"
  add_foreign_key "members", "bank_accounts"
  add_foreign_key "members_courses", "courses"
  add_foreign_key "members_courses", "members"
  add_foreign_key "posts", "users"
  add_foreign_key "read_logs", "posts"
  add_foreign_key "read_logs", "users"
  add_foreign_key "recesses", "members_courses"
  add_foreign_key "rolls", "lessons"
  add_foreign_key "rolls", "members"
  add_foreign_key "rolls", "rolls", column: "substitute_roll_id"
  add_foreign_key "studios", "schools"
  add_foreign_key "timetables", "studios"
  add_foreign_key "timetables", "time_slots"
  add_foreign_key "user_authentications", "users"
end
