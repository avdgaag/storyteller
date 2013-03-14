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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130311203456) do

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id",     :null => false
    t.string   "attachable_type",   :null => false
    t.integer  "user_id",           :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"
  add_index "attachments", ["user_id"], :name => "index_attachments_on_user_id"

  create_table "collaborations", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborations", ["project_id"], :name => "index_collaborations_on_project_id"
  add_index "collaborations", ["user_id"], :name => "index_collaborations_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body",             :null => false
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "epics", :force => true do |t|
    t.string   "title",                        :null => false
    t.text     "body"
    t.integer  "author_id",                    :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "stories_count", :default => 0
    t.integer  "project_id"
  end

  add_index "epics", ["author_id"], :name => "index_epics_on_author_id"
  add_index "epics", ["project_id"], :name => "index_epics_on_project_id"

  create_table "invitations", :force => true do |t|
    t.string   "email",      :null => false
    t.string   "token",      :null => false
    t.integer  "project_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitations", ["project_id"], :name => "index_invitations_on_project_id"
  add_index "invitations", ["token"], :name => "index_invitations_on_token"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "token"
    t.string   "external_id"
  end

  add_index "projects", ["owner_id"], :name => "index_projects_on_owner_id"

  create_table "requirements", :force => true do |t|
    t.string   "title",        :null => false
    t.datetime "completed_at"
    t.integer  "story_id",     :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "requirements", ["story_id"], :name => "index_requirements_on_story_id"

  create_table "stories", :force => true do |t|
    t.string   "title",                             :null => false
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "comments_count",     :default => 0
    t.datetime "completed_at"
    t.integer  "requirements_count", :default => 0
    t.integer  "owner_id"
    t.integer  "epic_id"
    t.integer  "project_id"
  end

  add_index "stories", ["epic_id"], :name => "index_stories_on_epic_id"
  add_index "stories", ["owner_id"], :name => "index_stories_on_owner_id"
  add_index "stories", ["project_id"], :name => "index_stories_on_project_id"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

end
