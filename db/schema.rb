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

ActiveRecord::Schema.define(version: 20150716071804) do

  create_table "alrams", force: true do |t|
    t.integer  "alram_id"
    t.string   "alram_type"
    t.integer  "user_id"
    t.integer  "friend_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "send_flg",       default: false
  end

  create_table "be_requested_friends", force: true do |t|
    t.integer  "user_id"
    t.integer  "request_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "feed_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["feed_id"], name: "index_comments_on_feed_id", using: :btree

  create_table "delete_recommend_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "recommend_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delete_recommend_users", ["user_id"], name: "index_delete_recommend_users_on_user_id", using: :btree

  create_table "feed_data", force: true do |t|
    t.integer  "user_id"
    t.integer  "main_id"
    t.string   "main_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_photos", force: true do |t|
    t.integer  "feed_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_tags", force: true do |t|
    t.integer  "feed_id"
    t.string   "tag_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.integer  "user_id"
    t.integer  "feed_type_id"
    t.text     "content"
    t.text     "html_content"
    t.integer  "like_count",    default: 0
    t.integer  "comment_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["id", "feed_type_id"], name: "index_feeds_on_id_and_feed_type_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "feed_id"
    t.integer  "user_id"
    t.string   "like_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["feed_id"], name: "index_likes_on_feed_id", using: :btree

  create_table "main_feeds", force: true do |t|
    t.integer  "user_id"
    t.integer  "main_id"
    t.string   "main_type"
    t.string   "sub_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_photos", force: true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_user_id"
    t.boolean  "is_friend",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "nick",                                   null: false
    t.date     "birthday"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
    t.text     "registration_id"
    t.boolean  "gender",                 default: false
    t.boolean  "alram_on",               default: true
    t.string   "word",                   default: ""
  end

  add_index "users", ["birthday"], name: "index_users_on_birthday", using: :btree

end
