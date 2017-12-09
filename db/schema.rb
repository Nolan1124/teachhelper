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

ActiveRecord::Schema.define(version: 20171209140208) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "a_id"
    t.integer  "course_id"
    t.string   "description"
    t.string   "a_secret_key"
    t.integer  "duration"
    t.datetime "gmt_time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "c_id"
    t.integer  "t_id"
    t.integer  "year"
    t.integer  "season"
    t.datetime "gmt_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "cname"
  end

  add_index "courses", ["t_id"], name: "index_courses_on_t_id"

  create_table "students", force: :cascade do |t|
    t.string   "sno"
    t.string   "sname"
    t.integer  "sage"
    t.string   "ssex"
    t.string   "sdept"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students", ["sno"], name: "index_students_on_sno", unique: true

  create_table "teachers", force: :cascade do |t|
    t.integer  "t_id"
    t.string   "username"
    t.string   "password"
    t.string   "eamil"
    t.datetime "gmt_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teachers", ["t_id"], name: "index_teachers_on_t_id", unique: true

end
