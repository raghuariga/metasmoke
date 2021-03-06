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

ActiveRecord::Schema.define(version: 20161025175958) do

  create_table "api_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "key"
    t.string   "app_name"
    t.integer  "user_id"
    t.string   "github_link"
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "api_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.integer  "api_key_id"
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiry"
    t.index ["api_key_id"], name: "index_api_tokens_on_api_key_id", using: :btree
    t.index ["user_id"], name: "index_api_tokens_on_user_id", using: :btree
  end

  create_table "blacklisted_websites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "host"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "commit_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "commit_sha"
    t.string   "status"
    t.string   "commit_message"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ci_url"
  end

  create_table "deletion_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "post_id"
    t.boolean  "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "post_id_ix", using: :btree
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "message_link"
    t.string   "user_name"
    t.string   "user_link"
    t.string   "feedback_type"
    t.integer  "post_id"
    t.string   "post_link"
    t.integer  "user_id"
    t.boolean  "is_invalidated", default: false
    t.integer  "invalidated_by"
    t.datetime "invalidated_at"
    t.integer  "chat_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_ignored",     default: false
    t.integer  "api_key_id"
    t.string   "chat_host"
    t.index ["post_id"], name: "index_feedbacks_on_post_id", using: :btree
  end

  create_table "flags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "reason"
    t.string   "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_completed", default: false
    t.integer  "post_id"
    t.index ["post_id"], name: "index_flags_on_post_id", using: :btree
  end

  create_table "ignored_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "user_name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_ignored"
    t.index ["user_id"], name: "index_ignored_users_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title"
    t.text     "body",                   limit: 65535
    t.string   "link"
    t.datetime "post_creation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.string   "user_link"
    t.string   "username"
    t.text     "why",                    limit: 65535
    t.integer  "user_reputation"
    t.integer  "score"
    t.integer  "upvote_count"
    t.integer  "downvote_count"
    t.integer  "stack_exchange_user_id"
    t.boolean  "is_tp",                                default: false
    t.boolean  "is_fp",                                default: false
    t.boolean  "is_naa",                               default: false
  end

  create_table "posts_reasons", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "reason_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_posts_reasons_on_post_id", using: :btree
    t.index ["reason_id"], name: "index_posts_reasons_on_reason_id", using: :btree
  end

  create_table "reasons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "reason_name"
    t.string  "last_post_title"
    t.boolean "inactive",        default: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "site_name"
    t.string   "site_url"
    t.string   "site_logo"
    t.string   "site_domain"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "smoke_detectors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "last_ping"
    t.string   "name"
    t.string   "location"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "email_date"
  end

  create_table "stack_exchange_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "username"
    t.datetime "last_api_update"
    t.boolean  "still_alive",     default: true
    t.integer  "answer_count"
    t.integer  "question_count"
    t.integer  "reputation"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "site_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "username"
    t.integer  "stackexchange_chat_id"
    t.integer  "meta_stackexchange_chat_id"
    t.integer  "stackoverflow_chat_id"
    t.integer  "stack_exchange_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "api_tokens", "api_keys"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "flags", "posts"
  add_foreign_key "ignored_users", "users"
end
