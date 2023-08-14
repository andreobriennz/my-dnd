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

ActiveRecord::Schema[7.0].define(version: 2023_08_13_233941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.text "description"
    t.boolean "public", default: false
    t.boolean "archived", default: false
    t.text "private_notes"
    t.text "shared_notes"
    t.date "date_started"
    t.string "slug"
    t.string "campaign_slug"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_adventures_on_campaign_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.text "description"
    t.boolean "public", default: false
    t.boolean "archived", default: false
    t.text "private_notes"
    t.text "shared_notes"
    t.date "date_started"
    t.date "date_ended"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.bigint "adventure_id"
    t.bigint "campaign_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.index ["adventure_id"], name: "index_comments_on_adventure_id"
    t.index ["campaign_id"], name: "index_comments_on_campaign_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "saved_magic_items", default: [], array: true
    t.string "saved_spells", default: [], array: true
    t.string "saved_monsters", default: [], array: true
    t.string "saved_weapons", default: [], array: true
    t.string "saved_armor", default: [], array: true
  end

  add_foreign_key "adventures", "campaigns"
  add_foreign_key "campaigns", "users"
  add_foreign_key "comments", "adventures"
  add_foreign_key "comments", "campaigns"
  add_foreign_key "comments", "users"
end
