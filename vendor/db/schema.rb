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

ActiveRecord::Schema.define(version: 20150519231148) do

  create_table "albums", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "user_id"
    t.integer  "cover_photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", force: true do |t|
    t.text     "headline"
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "body"
    t.integer  "vote_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "appreciations", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "question_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "testimony_id"
    t.integer  "prayer_request_id"
  end

  add_index "appreciations", ["article_id"], name: "index_appreciations_on_article_id", using: :btree
  add_index "appreciations", ["photo_id"], name: "index_appreciations_on_photo_id", using: :btree
  add_index "appreciations", ["prayer_request_id"], name: "index_appreciations_on_prayer_request_id", using: :btree
  add_index "appreciations", ["question_id"], name: "index_appreciations_on_question_id", using: :btree
  add_index "appreciations", ["testimony_id"], name: "index_appreciations_on_testimony_id", using: :btree
  add_index "appreciations", ["user_id"], name: "index_appreciations_on_user_id", using: :btree

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "view_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "auths", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "adult_1_first_name"
    t.string   "adult_1_last_name"
    t.string   "adult_1_chinese_name"
    t.string   "adult_1_email"
    t.string   "adult_2_first_name"
    t.string   "adult_2_last_name"
    t.string   "adult_2_chinese_name"
    t.string   "adult_2_email"
    t.string   "home_phone"
    t.string   "street_no_and_name"
    t.string   "city"
    t.string   "zip"
    t.string   "child_1_first_name"
    t.string   "child_2_first_name"
    t.string   "child_3_first_name"
    t.string   "child_4_first_name"
    t.string   "child_5_first_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "adult_1_phone"
    t.string   "adult_2_phone"
    t.string   "child_1_last_name"
    t.string   "child_2_last_name"
    t.string   "child_3_last_name"
    t.string   "child_4_last_name"
    t.integer  "photo_number"
    t.integer  "user_id"
    t.boolean  "verified",             default: false
    t.boolean  "disabled",             default: false
    t.string   "child_1_relation",     default: "child"
    t.string   "child_2_relation",     default: "child"
    t.string   "child_3_relation",     default: "child"
    t.string   "child_4_relation",     default: "child"
    t.string   "child_5_relation",     default: "child"
    t.string   "child_5_last_name"
    t.string   "child_1_chinese_name"
    t.string   "child_2_chinese_name"
    t.string   "child_3_chinese_name"
    t.string   "child_4_chinese_name"
    t.string   "child_5_chinese_name"
    t.integer  "adult_1_phone_ext"
    t.integer  "adult_2_phone_ext"
    t.string   "country",              default: "US"
    t.string   "key"
    t.string   "note"
  end

  create_table "critiques", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.text     "body"
    t.integer  "vote_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "critiques", ["photo_id"], name: "index_critiques_on_photo_id", using: :btree
  add_index "critiques", ["user_id"], name: "index_critiques_on_user_id", using: :btree

  create_table "docs", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "echos", force: true do |t|
    t.integer  "user_id"
    t.integer  "testimony_id"
    t.text     "body"
    t.integer  "vote_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "echos", ["testimony_id"], name: "index_echos_on_testimony_id", using: :btree
  add_index "echos", ["user_id"], name: "index_echos_on_user_id", using: :btree

  create_table "fanships", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorite_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fanships", ["favorite_user_id"], name: "index_fanships_on_favorite_user_id", using: :btree
  add_index "fanships", ["user_id"], name: "index_fanships_on_user_id", using: :btree

  create_table "faves", force: true do |t|
    t.integer  "faveable_id",   null: false
    t.string   "faveable_type", null: false
    t.integer  "faver_id"
    t.string   "faver_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faves", ["faveable_id", "faveable_type"], name: "index_faves_on_faveable_id_and_faveable_type", using: :btree
  add_index "faves", ["faver_id", "faver_type", "faveable_id", "faveable_type"], name: "fk_one_fave_per_user_per_model", unique: true, using: :btree
  add_index "faves", ["faver_id", "faver_type"], name: "index_faves_on_faver_id_and_faver_type", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hits", force: true do |t|
    t.integer  "referrer_url_id"
    t.string   "ip"
    t.string   "host"
    t.string   "browser_name"
    t.string   "browser_version"
    t.string   "browser_platform"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "hits", ["referrer_url_id"], name: "index_hits_on_referrer_url_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "view_count",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "taken_at"
    t.datetime "date_digitized"
    t.datetime "date_original"
    t.string   "make"
    t.string   "model"
    t.integer  "width"
    t.integer  "height"
    t.string   "f_number"
    t.string   "focal_length"
    t.string   "exposure_time"
    t.integer  "iso"
    t.integer  "flash"
    t.integer  "white_balance"
    t.integer  "exposure_program"
    t.string   "exposure_bias_value"
    t.integer  "metering_mode"
    t.string   "image_remote_url"
    t.integer  "album_id"
    t.string   "image_referer_url"
    t.integer  "rating",              default: 0
    t.integer  "base_view_count",     default: 0
    t.string   "slug"
    t.string   "image_remote_id"
  end

  add_index "photos", ["image_remote_id"], name: "index_photos_on_image_remote_id", using: :btree
  add_index "photos", ["slug"], name: "index_photos_on_slug", unique: true, using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "piles", force: true do |t|
    t.integer  "collection_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "piles", ["collection_id"], name: "index_piles_on_collection_id", using: :btree
  add_index "piles", ["photo_id"], name: "index_piles_on_photo_id", using: :btree

  create_table "prayer_requests", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "view_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prayer_requests", ["user_id"], name: "index_prayer_requests_on_user_id", using: :btree

  create_table "prayers", force: true do |t|
    t.integer  "user_id"
    t.integer  "prayer_request_id"
    t.text     "body"
    t.integer  "vote_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prayers", ["prayer_request_id"], name: "index_prayers_on_prayer_request_id", using: :btree
  add_index "prayers", ["user_id"], name: "index_prayers_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "real_name"
    t.string   "location"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "view_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "referrer_urls", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reputations", force: true do |t|
    t.integer  "points"
    t.string   "reason"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "critique_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reputations", ["critique_id"], name: "index_reputations_on_critique_id", using: :btree
  add_index "reputations", ["photo_id"], name: "index_reputations_on_photo_id", using: :btree
  add_index "reputations", ["user_id"], name: "index_reputations_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "body"
    t.integer  "vote_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["article_id"], name: "index_reviews_on_article_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "services", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "label"
    t.string   "identifier"
    t.text     "body"
    t.string   "field_type", default: "string"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "testimonies", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "view_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testimonies", ["user_id"], name: "index_testimonies_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 100
    t.string   "encrypted_password",     limit: 128, default: "",                     null: false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login",                  limit: 40
    t.string   "identity_url"
    t.string   "name",                   limit: 100, default: ""
    t.string   "state",                              default: "passive"
    t.string   "twitter_token"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
    t.string   "location"
    t.text     "about_me"
    t.string   "real_name"
    t.date     "birthday"
    t.datetime "seen"
    t.integer  "reputation_count",                   default: 0
    t.integer  "view_count",                         default: 0
    t.integer  "profile_photo_id"
    t.string   "copyright",                          default: "All rights reserved."
    t.integer  "referrer_url_id"
    t.text     "css"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.boolean  "vote",          default: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
