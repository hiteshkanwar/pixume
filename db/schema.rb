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

ActiveRecord::Schema.define(:version => 20140220081546) do

  create_table "achievement_categories", :force => true do |t|
    t.string   "name",                                         :null => false
    t.string   "description"
    t.boolean  "is_public"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "icon_image",  :default => "increased-roi.png"
  end

  add_index "achievement_categories", ["name"], :name => "index_achievement_categories_on_name", :unique => true

  create_table "achievements", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "achievement", :default => 0
    t.string   "category"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.string   "expires_in"
    t.text     "api_response"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "company_name",     :null => false
    t.string   "company_industry", :null => false
    t.string   "company_desc",     :null => false
    t.string   "company_location", :null => false
    t.string   "company_country",  :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "companies", ["company_country"], :name => "index_companies_on_company_country"
  add_index "companies", ["company_location"], :name => "index_companies_on_company_location"
  add_index "companies", ["company_name"], :name => "index_companies_on_company_name", :unique => true

  create_table "course_ratings", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "score",      :default => 1, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "course_ratings", ["name"], :name => "index_course_ratings_on_name", :unique => true

  create_table "educations", :force => true do |t|
    t.integer  "user_id"
    t.string   "institute"
    t.string   "course"
    t.string   "from_month"
    t.string   "from_year"
    t.string   "to_month"
    t.string   "to_year"
    t.boolean  "currently_attending"
    t.string   "location"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "linkedin_id"
  end

  create_table "experiences", :force => true do |t|
    t.integer  "user_id"
    t.string   "designation"
    t.string   "position"
    t.string   "from_month"
    t.string   "from_year"
    t.string   "to_month"
    t.string   "to_year"
    t.string   "duration"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "company_name"
    t.string   "city"
    t.string   "country"
    t.string   "linkedin_id"
    t.boolean  "is_current",   :default => false
  end

  create_table "job_applications", :force => true do |t|
    t.integer  "job_posting_id"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "availablity"
    t.integer  "expected_salary"
    t.string   "best_fit_for_job"
    t.string   "currency"
  end

  create_table "job_posting_skill_sets", :force => true do |t|
    t.integer  "job_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "job_postings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "title",                                     :null => false
    t.text     "description",                               :null => false
    t.string   "requirements",                              :null => false
    t.string   "salary"
    t.integer  "min_years_exp"
    t.integer  "max_years_exp"
    t.string   "location",                                  :null => false
    t.string   "country",                                   :null => false
    t.boolean  "show_matching_profiles", :default => false, :null => false
    t.boolean  "is_public",              :default => false, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "num_connections"
    t.integer  "num_recommendations"
    t.integer  "num_groups"
    t.integer  "num_posts_per_month"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "requestors", :force => true do |t|
    t.string   "requestor_name"
    t.string   "requestor_email"
    t.date     "requested_date"
    t.integer  "user_id"
    t.integer  "skill_set_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "paid"
    t.string   "link"
    t.string   "source"
    t.integer  "user_id"
    t.boolean  "approved"
    t.integer  "skill_set_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "resource_name"
  end

  add_index "resources", ["skill_set_id"], :name => "index_resources_on_skill_set_id"

  create_table "resume_files", :force => true do |t|
    t.integer  "job_application_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
  end

  add_index "resume_files", ["job_application_id"], :name => "index_resume_files_on_job_application_id"

  create_table "school_ratings", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "score",      :default => 1, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "school_ratings", ["name"], :name => "index_school_ratings_on_name", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "skill_categories", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.boolean  "is_public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "skill_categories", ["name"], :name => "index_skill_categories_on_name", :unique => true

  create_table "skill_sets", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "expertise_level"
    t.string   "category"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "linkedin_id"
    t.integer  "expertise_level_id"
  end

  create_table "usage_trackings", :force => true do |t|
    t.string   "session_id"
    t.string   "user_name"
    t.string   "user_email"
    t.string   "last_access_url"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_locations", :force => true do |t|
    t.integer  "zip"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_locations", ["user_id"], :name => "index_user_locations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                      :default => "",        :null => false
    t.string   "encrypted_password",         :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "position"
    t.string   "phone"
    t.string   "about"
    t.text     "summary"
    t.string   "video_url"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.boolean  "visited_profile",            :default => false
    t.boolean  "published_profile",          :default => false
    t.string   "role",                       :default => "default", :null => false
    t.integer  "company_id",                 :default => 1,         :null => false
    t.boolean  "checked"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
