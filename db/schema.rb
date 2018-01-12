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

ActiveRecord::Schema.define(version: 20180112132028) do

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

  add_index "assignments", ["a_id"], name: "index_assignments_on_a_id", unique: true

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

  add_index "courses", ["c_id"], name: "index_courses_on_c_id", unique: true

  create_table "teachers", force: :cascade do |t|
    t.integer  "t_id"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.datetime "gmt_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "teachers", ["t_id"], name: "index_teachers_on_t_id", unique: true

end
