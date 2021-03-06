# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_07_220909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "token", null: false
    t.string "name", null: false
    t.integer "chat_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_apps_on_token", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.string "app_token"
    t.integer "message_count", default: 0
    t.integer "chat_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chat_number_app_token", null: false
    t.index ["chat_number_app_token"], name: "index_chats_on_chat_number_app_token", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "message_number"
    t.string "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chat_ref"
  end

  add_foreign_key "chats", "apps", column: "app_token", primary_key: "token"
  add_foreign_key "messages", "chats", column: "chat_ref", primary_key: "chat_number_app_token", on_delete: :cascade
end
