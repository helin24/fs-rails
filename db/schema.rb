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

ActiveRecord::Schema.define(version: 20141114230833) do

  create_table "coachings", force: true do |t|
    t.integer  "skater_id"
    t.integer  "coach_id"
    t.date     "relationship_began"
    t.boolean  "skater_confirmed",   default: false
    t.boolean  "coach_confirmed",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elements", force: true do |t|
    t.integer  "routine_id"
    t.integer  "elementable_id"
    t.string   "elementable_type"
    t.time     "time"
    t.integer  "repetitions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "top"
    t.float    "left"
  end

  add_index "elements", ["routine_id"], name: "index_elements_on_routine_id"

  create_table "field_moves", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.integer  "test_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_moves", ["test_level_id"], name: "index_field_moves_on_test_level_id"

  create_table "field_moves_skills", force: true do |t|
    t.integer "skill_id"
    t.integer "field_move_id"
  end

  add_index "field_moves_skills", ["field_move_id"], name: "index_field_moves_skills_on_field_move_id"
  add_index "field_moves_skills", ["skill_id"], name: "index_field_moves_skills_on_skill_id"

  create_table "levels", force: true do |t|
    t.string   "name"
    t.string   "organization"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.text     "text"
    t.string   "source"
    t.integer  "public"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.integer  "user_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["author_id"], name: "index_notes_on_author_id"
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "routines", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "author_id"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routines", ["author_id"], name: "index_routines_on_author_id"
  add_index "routines", ["user_id"], name: "index_routines_on_user_id"

  create_table "skills", force: true do |t|
    t.string   "name"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_levels", force: true do |t|
    t.string   "name"
    t.string   "standard_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "about"
    t.date     "birthday"
    t.date     "started_skating"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "users_field_moves", force: true do |t|
    t.integer  "user_id"
    t.integer  "field_move_id"
    t.integer  "users_test_level_id"
    t.integer  "progress",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_field_moves", ["field_move_id"], name: "index_users_field_moves_on_field_move_id"
  add_index "users_field_moves", ["user_id"], name: "index_users_field_moves_on_user_id"
  add_index "users_field_moves", ["users_test_level_id"], name: "index_users_field_moves_on_users_test_level_id"

  create_table "users_levels", force: true do |t|
    t.integer  "user_id"
    t.integer  "level_id"
    t.integer  "learned_points", default: 0
    t.integer  "total_points",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_levels", ["level_id"], name: "index_users_levels_on_level_id"
  add_index "users_levels", ["user_id"], name: "index_users_levels_on_user_id"

  create_table "users_skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "users_level_id"
    t.integer  "progress",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_skills", ["skill_id"], name: "index_users_skills_on_skill_id"
  add_index "users_skills", ["user_id"], name: "index_users_skills_on_user_id"
  add_index "users_skills", ["users_level_id"], name: "index_users_skills_on_users_level_id"

  create_table "users_test_levels", force: true do |t|
    t.integer  "user_id"
    t.integer  "test_level_id"
    t.date     "achieved_on"
    t.integer  "learned_points", default: 0
    t.integer  "total_points",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_test_levels", ["test_level_id"], name: "index_users_test_levels_on_test_level_id"
  add_index "users_test_levels", ["user_id"], name: "index_users_test_levels_on_user_id"

end
