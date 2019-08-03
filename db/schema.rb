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

ActiveRecord::Schema.define(version: 2019_08_03_201135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "team_invites", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "invite_token"
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_token"], name: "index_team_invites_on_invite_token"
    t.index ["team_id"], name: "index_team_invites_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_invites_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_invites_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "teams_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id", "team_id"], name: "index_teams_users_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "team_invites", "teams"
  add_foreign_key "team_invites", "users"
end
