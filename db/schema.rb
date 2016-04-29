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

ActiveRecord::Schema.define(version: 20160429153824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ip",             limit: 255
    t.string   "remote_ip",      limit: 255
    t.string   "request_method", limit: 255
    t.string   "fullpath",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "age_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "holder_name",      limit: 255
    t.string   "holder_name_kana", limit: 255
    t.string   "bank_id",          limit: 255
    t.string   "bank_name",        limit: 255
    t.string   "branch_id",        limit: 255
    t.string   "branch_name",      limit: 255
    t.string   "account_number",   limit: 255
    t.string   "status",           limit: 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "receipt_date"
    t.date     "ship_date"
    t.date     "begin_date"
    t.boolean  "imperfect"
    t.boolean  "change_bank"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "timetable_id"
    t.integer  "instructor_id"
    t.integer  "dance_style_id"
    t.integer  "level_id"
    t.integer  "age_group_id"
    t.date     "open_date"
    t.date     "close_date"
    t.text     "note"
    t.integer  "monthly_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dance_styles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "holidays", force: :cascade do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "kana",           limit: 255
    t.string   "team",           limit: 255
    t.string   "phone",          limit: 255
    t.string   "email_pc",       limit: 255
    t.string   "email_mobile",   limit: 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "transportation"
    t.boolean  "taxable"
    t.integer  "guaranteed_min"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "course_id"
    t.date     "date"
    t.string   "rolls_status", limit: 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       limit: 255
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "first_name_kana", limit: 255
    t.string   "last_name_kana",  limit: 255
    t.string   "gender",          limit: 255
    t.date     "birth_date"
    t.string   "zip",             limit: 255
    t.string   "address",         limit: 255
    t.string   "phone_mobile",    limit: 255
    t.string   "email_pc",        limit: 255
    t.string   "email_mobile",    limit: 255
    t.text     "note"
    t.date     "enter_date"
    t.date     "leave_date"
    t.integer  "bank_account_id"
    t.string   "status",          limit: 255
    t.string   "nearby_station",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_land",      limit: 255
    t.string   "number",          limit: 255
  end

  create_table "members_courses", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "course_id"
    t.date     "begin_date"
    t.date     "end_date"
    t.text     "note"
    t.boolean  "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content"
    t.integer  "user_id"
    t.date     "open_date"
    t.date     "close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "read_logs", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "read_comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recesses", force: :cascade do |t|
    t.integer  "members_course_id"
    t.string   "month",             limit: 255
    t.string   "status",            limit: 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "member_id"
    t.string   "status",             limit: 255
    t.integer  "substitute_roll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rolls", ["lesson_id"], name: "index_rolls_on_lesson_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "zip",        limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "open_date"
    t.date     "close_date"
  end

  create_table "studios", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "note",       limit: 255
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "open_date"
    t.date     "close_date"
  end

  create_table "time_slots", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", force: :cascade do |t|
    t.integer  "studio_id"
    t.integer  "weekday"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
    t.string   "status",                 limit: 255
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
