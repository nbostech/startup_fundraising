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

ActiveRecord::Schema.define(version: 20160318144954) do

  create_table "event_rsvps", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.string   "rsvp_type",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "event_rsvps", ["user_id"], name: "index_event_rsvps_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.string   "address",            limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "location",           limit: 255
    t.boolean  "is_public",                        default: true
    t.boolean  "is_active",                        default: true
    t.integer  "user_id",            limit: 4
    t.string   "tenant_id",          limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "events", ["tenant_id"], name: "index_events_on_tenant_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "favourites", force: :cascade do |t|
    t.integer  "favourited_id",   limit: 4
    t.string   "favourited_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "favourites", ["favourited_type", "favourited_id"], name: "index_favourites_on_favourited_type_and_favourited_id", using: :btree
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id", using: :btree

  create_table "investments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "startup_id", limit: 4
    t.integer  "amount",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name",             limit: 255
    t.string   "email",                 limit: 255
    t.integer  "contact_number",        limit: 4
    t.integer  "company_name",          limit: 4
    t.string   "startup_name",          limit: 255
    t.integer  "emp_strength",          limit: 4
    t.string   "founder_name",          limit: 255
    t.string   "location",              limit: 255
    t.string   "website",               limit: 255
    t.string   "business_category",     limit: 255
    t.text     "business_summary",      limit: 65535
    t.string   "description",           limit: 255
    t.text     "profile_summary",       limit: 65535
    t.string   "profile_links",         limit: 255
    t.string   "social_accounts",       limit: 255
    t.boolean  "is_funded"
    t.integer  "current_fund",          limit: 4
    t.integer  "required_fund",         limit: 4
    t.string   "idn_image_url",         limit: 255
    t.string   "shared_document_url",   limit: 255
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uuid",       limit: 255
    t.boolean  "is_active",              default: false
    t.string   "tenant_id",  limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id", using: :btree

end
