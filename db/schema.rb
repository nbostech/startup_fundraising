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

ActiveRecord::Schema.define(version: 20160708112258) do

  create_table "address_types", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
    t.string "tenant_id",   limit: 255
  end

  create_table "addresses", force: :cascade do |t|
    t.float    "longitude",        limit: 24
    t.float    "latitude",         limit: 24
    t.string   "address1",         limit: 255
    t.string   "street",           limit: 255
    t.string   "city",             limit: 255
    t.string   "state",            limit: 255
    t.string   "country",          limit: 255
    t.integer  "zip_code",         limit: 4
    t.integer  "address_type_id",  limit: 4
    t.integer  "addressable_id",   limit: 4
    t.string   "addressable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "annual_financial_details", force: :cascade do |t|
    t.integer "revenue_driver_count",     limit: 8
    t.integer "revenue",                  limit: 8
    t.integer "expenditure",              limit: 8
    t.integer "annual_financial_info_id", limit: 4
    t.integer "year",                     limit: 4
  end

  create_table "annual_financial_infos", force: :cascade do |t|
    t.integer "annual_revenue_run_rate", limit: 8
    t.integer "monthly_bun_rate",        limit: 8
    t.text    "financial_annotation",    limit: 65535
    t.string  "revenue_driver",          limit: 255
    t.integer "company_id",              limit: 4
  end

  create_table "assets", force: :cascade do |t|
    t.string   "img_type",           limit: 255
    t.integer  "imageable_id",       limit: 4
    t.string   "imageable_type",     limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "assets", ["imageable_type", "imageable_id"], name: "index_assets_on_imageable_type_and_imageable_id", using: :btree

  create_table "associate_teams", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
    t.string "tenant_id",   limit: 255
  end

  create_table "commitment_types", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "tenant_id",   limit: 255
    t.string  "description", limit: 255
    t.boolean "is_deleted"
    t.boolean "is_active"
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "company_category_id", limit: 4
    t.integer  "company_stage_id",    limit: 4
    t.integer  "currency_type_id",    limit: 4
    t.boolean  "is_funded",                     default: false
    t.boolean  "is_approved",                   default: false
    t.boolean  "is_published",                  default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "companies_users", force: :cascade do |t|
    t.integer "company_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  create_table "company_associates", force: :cascade do |t|
    t.string  "name",                     limit: 255
    t.string  "email",                    limit: 255
    t.integer "company_id",               limit: 4
    t.integer "associate_team_id",        limit: 4
    t.string  "position",                 limit: 255
    t.text    "experience_and_expertise", limit: 65535
    t.string  "contact_number",           limit: 255
    t.string  "location",                 limit: 255
    t.string  "website",                  limit: 255
    t.text    "profile_summary",          limit: 65535
    t.string  "linkedin_profile",         limit: 255
    t.string  "facebook_profile",         limit: 255
    t.string  "twitter_profile",          limit: 255
    t.string  "other_profile",            limit: 255
  end

  create_table "company_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "tenant_id",   limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "company_categories_profiles", force: :cascade do |t|
    t.integer "profile_id",          limit: 4
    t.integer "company_category_id", limit: 4
  end

  add_index "company_categories_profiles", ["company_category_id"], name: "index_company_categories_profiles_on_company_category_id", using: :btree
  add_index "company_categories_profiles", ["profile_id"], name: "index_company_categories_profiles_on_profile_id", using: :btree

  create_table "company_executive_summaries", force: :cascade do |t|
    t.integer  "company_summary_type_id", limit: 4
    t.integer  "company_id",              limit: 4
    t.text     "description",             limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "company_profiles", force: :cascade do |t|
    t.string   "startup_name",           limit: 255
    t.string   "email",                  limit: 255
    t.string   "contact_number",         limit: 255
    t.integer  "emp_strength",           limit: 4
    t.string   "founder_name",           limit: 255
    t.string   "location",               limit: 255
    t.string   "website",                limit: 255
    t.text     "business_summary",       limit: 65535
    t.text     "description",            limit: 65535
    t.text     "usb_product_uniqueness", limit: 65535
    t.integer  "company_id",             limit: 4
    t.integer  "date_founded",           limit: 4
    t.integer  "year_founded",           limit: 4
    t.string   "linkedin_profile_url",   limit: 255
    t.string   "twitter_profile_url",    limit: 255
    t.string   "facebook_profile_url",   limit: 255
    t.string   "other_profile_url",      limit: 255
    t.integer  "capital_raised",         limit: 4
    t.integer  "previous_capital",       limit: 4
    t.integer  "monthly_net_burn",       limit: 4
    t.integer  "pre_money_valuation",    limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "company_profiles", ["company_id"], name: "index_company_profiles_on_company_id", using: :btree

  create_table "company_stages", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "tenant_id",   limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "company_summary_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "tenant_id",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "currency_types", force: :cascade do |t|
    t.string "code",        limit: 255
    t.string "symbol",      limit: 255
    t.string "tenant_id",   limit: 255
    t.string "description", limit: 255
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "tenant_id",   limit: 255
    t.string "description", limit: 255
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "document_type_id",      limit: 4
    t.integer  "attachable_id",         limit: 4
    t.string   "attachable_type",       limit: 255
    t.string   "content_type",          limit: 255
    t.string   "content_provider_url",  limit: 255
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
  end

  add_index "documents", ["attachable_type", "attachable_id"], name: "index_documents_on_attachable_type_and_attachable_id", using: :btree

  create_table "domain_expertises", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "tenant_id",   limit: 255
    t.string  "description", limit: 255
    t.integer "parent_id",   limit: 4
  end

  create_table "domain_expertises_profiles", force: :cascade do |t|
    t.integer "profile_id",          limit: 4
    t.integer "domain_expertise_id", limit: 4
  end

  add_index "domain_expertises_profiles", ["domain_expertise_id"], name: "index_domain_expertises_profiles_on_domain_expertise_id", using: :btree
  add_index "domain_expertises_profiles", ["profile_id"], name: "index_domain_expertises_profiles_on_profile_id", using: :btree

  create_table "event_assets", force: :cascade do |t|
    t.string   "img_type",           limit: 255
    t.integer  "imageable_id",       limit: 4
    t.string   "imageable_type",     limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "event_assets", ["imageable_type", "imageable_id"], name: "index_event_assets_on_imageable_type_and_imageable_id", using: :btree

  create_table "event_rsvps", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.string   "rsvp_type",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uuid",       limit: 255
  end

  add_index "event_rsvps", ["user_id"], name: "index_event_rsvps_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description",    limit: 65535
    t.string   "address",        limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "location",       limit: 255
    t.boolean  "is_public",                    default: true
    t.boolean  "is_active",                    default: true
    t.integer  "user_id",        limit: 4
    t.string   "tenant_id",      limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "contact_person", limit: 255
    t.string   "contact_number", limit: 255
    t.string   "website",        limit: 255
    t.string   "uuid",           limit: 255
  end

  add_index "events", ["tenant_id"], name: "index_events_on_tenant_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "favoritable_id",   limit: 4
    t.string   "favoritable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "favorites", ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable_type_and_favoritable_id", using: :btree

  create_table "funding_round_types", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
    t.string "tenant_id",   limit: 255
  end

  create_table "funding_rounds", force: :cascade do |t|
    t.integer  "seeking_amount",        limit: 4
    t.date     "closing_date"
    t.boolean  "is_closed",                       default: false
    t.integer  "company_id",            limit: 4
    t.boolean  "is_deleted",                      default: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "funding_round_type_id", limit: 4
    t.integer  "minimum_investment",    limit: 4
  end

  create_table "investment_commitments", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "funding_round_id",   limit: 4
    t.integer  "invested_amount",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "commitment_type_id", limit: 4
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name",        limit: 255
    t.string   "email",            limit: 255
    t.string   "contact_number",   limit: 255
    t.string   "location",         limit: 255
    t.string   "website",          limit: 255
    t.text     "profile_summary",  limit: 65535
    t.string   "linkedin_profile", limit: 255
    t.string   "facebook_profile", limit: 255
    t.string   "twitter_profile",  limit: 255
    t.string   "other_profile",    limit: 255
    t.string   "social_accounts",  limit: 255
    t.string   "idn_image_url",    limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "code",        limit: 255
    t.string   "tenant_id",   limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "roles_users", force: :cascade do |t|
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
