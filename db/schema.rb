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

ActiveRecord::Schema.define(version: 20130929080036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "bank_accounts", force: true do |t|
    t.string   "holder_name"
    t.string   "holder_name_kana"
    t.string   "bank_id"
    t.string   "bank_name"
    t.string   "branch_id"
    t.string   "branch_name"
    t.string   "account_number"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
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

  create_table "dance_styles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "debits", force: true do |t|
    t.integer  "bank_account_id"
    t.string   "month"
    t.integer  "amount"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: true do |t|
    t.string   "name"
    t.string   "kana"
    t.string   "team"
    t.string   "phone"
    t.string   "email_pc"
    t.string   "email_mobile"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.integer  "course_id"
    t.date     "date"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_no"
  end

  create_table "members", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "first_name_kana"
    t.string   "last_name_kana"
    t.string   "gender"
    t.date     "birth_date"
    t.string   "zip"
    t.string   "address"
    t.string   "phone"
    t.string   "email_pc"
    t.string   "email_mobile"
    t.text     "note"
    t.date     "enter_date"
    t.date     "leave_date"
    t.integer  "bank_account_id"
    t.string   "status"
    t.string   "nearby_station"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members_courses", force: true do |t|
    t.integer  "member_id"
    t.integer  "course_id"
    t.date     "begin_date"
    t.date     "end_date"
    t.text     "note"
    t.boolean  "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.integer  "member_id"
    t.string   "month"
    t.integer  "amount"
    t.string   "method"
    t.date     "date"
    t.string   "status"
    t.integer  "debit_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recesses", force: true do |t|
    t.integer  "members_course_id"
    t.string   "month"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "member_id"
    t.string   "status"
    t.integer  "substitute_roll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "zip"
    t.string   "address"
    t.string   "phone"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "open_date"
    t.date     "close_date"
  end

  create_table "studios", force: true do |t|
    t.string   "name"
    t.string   "note"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "open_date"
    t.date     "close_date"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "frequency"
    t.date     "due_date"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", force: true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", force: true do |t|
    t.integer  "studio_id"
    t.integer  "weekday"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
