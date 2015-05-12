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

ActiveRecord::Schema.define(version: 20150512053715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "student_id"
    t.integer  "attendance_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id", using: :btree
  add_index "attendances", ["student_id"], name: "index_attendances_on_student_id", using: :btree

  create_table "classgroups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "classgroups", ["user_id"], name: "index_classgroups_on_user_id", using: :btree

  create_table "classgroups_students", force: :cascade do |t|
    t.integer  "classgroup_id"
    t.integer  "student_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "classgroups_students", ["classgroup_id"], name: "index_classgroups_students_on_classgroup_id", using: :btree
  add_index "classgroups_students", ["student_id"], name: "index_classgroups_students_on_student_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "classgroup_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "google_event_id"
  end

  add_index "events", ["classgroup_id"], name: "index_events_on_classgroup_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.text     "note"
    t.date     "dob"
    t.string   "email"
    t.string   "phone_number"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "notifications"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone_number"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_hash"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "refresh_hash"
    t.datetime "hash_expires_at"
  end

  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "students"
  add_foreign_key "classgroups", "users"
  add_foreign_key "classgroups_students", "classgroups"
  add_foreign_key "classgroups_students", "students"
  add_foreign_key "events", "classgroups"
end
