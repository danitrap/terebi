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

ActiveRecord::Schema.define(version: 20131217162710) do

  create_table "episodes", force: true do |t|
    t.string   "name"
    t.integer  "episode"
    t.text     "path"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "overview"
    t.text     "thumb"
    t.date     "air_date"
    t.integer  "season"
  end

  add_index "episodes", ["name", "season", "episode", "updated_at"], name: "index_episodes_on_name_and_season_and_episode_and_updated_at"
  add_index "episodes", ["path"], name: "index_episodes_on_path"

  create_table "series", force: true do |t|
    t.string   "name"
    t.string   "poster"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imdb_id"
    t.string   "banner"
    t.text     "overview"
  end

  add_index "series", ["name", "updated_at"], name: "index_series_on_name_and_updated_at"

end
