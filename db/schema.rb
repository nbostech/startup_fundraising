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

ActiveRecord::Schema.define(version: 20160427141640) do

  create_table "associate_teams", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "company_category_id", limit: 4
    t.integer  "company_stage_id",    limit: 4
    t.integer  "currency_type_id",    limit: 4
    t.boolean  "is_funded",                     default: false
    t.boolean  "is_approved",                   default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "companies_users", force: :cascade do |t|
    t.integer "company_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  create_table "company_associates", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "email",                    limit: 255
    t.integer  "company_id",               limit: 4
    t.integer  "associate_category_id",    limit: 4
    t.string   "position",                 limit: 255
    t.text     "experience_and_expertise", limit: 65535
    t.string   "image_file_name",          limit: 255
    t.string   "image_content_type",       limit: 255
    t.integer  "image_file_size",          limit: 4
    t.datetime "image_updated_at"
  end

  create_table "company_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "company_profiles", force: :cascade do |t|
    t.string   "startup_name",           limit: 255
    t.string   "email",                  limit: 255
    t.integer  "contact_number",         limit: 4
    t.integer  "emp_strength",           limit: 4
    t.string   "founder_name",           limit: 255
    t.string   "location",               limit: 255
    t.text     "address",                limit: 65535
    t.string   "website",                limit: 255
    t.text     "business_summary",       limit: 65535
    t.text     "description",            limit: 65535
    t.text     "usb_product_uniqueness", limit: 65535
    t.integer  "company_id",             limit: 4
    t.integer  "date_funded",            limit: 4
    t.integer  "year_funded",            limit: 4
    t.string   "linkedin_media_url",     limit: 255
    t.string   "twitter_media_url",      limit: 255
    t.string   "facebook_media_url",     limit: 255
    t.string   "other_media_url",        limit: 255
    t.integer  "capital_raised",         limit: 4
    t.integer  "previous_capital",       limit: 4
    t.integer  "monthly_net_burn",       limit: 4
    t.integer  "pre_money_valuation",    limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "document_file_name",     limit: 255
    t.string   "document_content_type",  limit: 255
    t.integer  "document_file_size",     limit: 4
    t.datetime "document_updated_at"
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size",        limit: 4
    t.datetime "image_updated_at"
  end

  add_index "company_profiles", ["company_id"], name: "index_company_profiles_on_company_id", using: :btree

  create_table "company_stages", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "currency_types", force: :cascade do |t|
    t.string "code",        limit: 255
    t.string "symbol",      limit: 255
    t.string "description", limit: 255
  end

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
    t.string   "contact_person",     limit: 255
    t.integer  "contact_number",     limit: 4
    t.string   "website",            limit: 255
  end

  add_index "events", ["tenant_id"], name: "index_events_on_tenant_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "favourites", force: :cascade do |t|
    t.integer  "favouritable_id",   limit: 4
    t.string   "favouritable_type", limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "favourites", ["favouritable_type", "favouritable_id"], name: "index_favourites_on_favouritable_type_and_favouritable_id", using: :btree

  create_table "funding_rounds", force: :cascade do |t|
    t.integer  "seeking_amount", limit: 4
    t.date     "closing_date"
    t.boolean  "is_closed",                default: false
    t.integer  "company_id",     limit: 4
    t.boolean  "is_deleted",               default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "investments", force: :cascade do |t|
    t.integer  "user_id",                  limit: 4
    t.integer  "current_funding_round_id", limit: 4
    t.integer  "invested_amount",          limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name",             limit: 255
    t.string   "email",                 limit: 255
    t.integer  "contact_number",        limit: 4
    t.string   "location",              limit: 255
    t.text     "address",               limit: 65535
    t.string   "website",               limit: 255
    t.text     "profile_summary",       limit: 65535
    t.string   "linkedin_profile",      limit: 255
    t.string   "facebook_profile",      limit: 255
    t.string   "twitter_profile",       limit: 255
    t.string   "other_profile",         limit: 255
    t.string   "social_accounts",       limit: 255
    t.string   "idn_image_url",         limit: 255
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
    t.string   "code",        limit: 255
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
    t.string   "uuid",        limit: 255
    t.boolean  "is_public",               default: true
    t.boolean  "is_approved",             default: false
    t.boolean  "is_delete",               default: false
    t.string   "tenant_id",   limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id", using: :btree

end
