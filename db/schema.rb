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

ActiveRecord::Schema.define(version: 2021_03_08_002039) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidate_profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "biography"
    t.string "cellphone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_candidate_profiles_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "email_domain", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "description"
    t.string "cnpj"
    t.date "creation_date"
    t.string "address"
    t.string "site"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "employee_profiles", force: :cascade do |t|
    t.string "employee_code"
    t.string "role"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", null: false
    t.index ["company_id"], name: "index_employee_profiles_on_company_id"
    t.index ["user_id"], name: "index_employee_profiles_on_user_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.integer "candidate_profile_id", null: false
    t.integer "job_opportunity_id", null: false
    t.integer "status", default: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_profile_id"], name: "index_job_applications_on_candidate_profile_id"
    t.index ["job_opportunity_id"], name: "index_job_applications_on_job_opportunity_id"
  end

  create_table "job_opportunities", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.float "max_salary", default: 0.0, null: false
    t.float "min_salary", default: 0.0, null: false
    t.integer "professional_level", default: 3, null: false
    t.date "application_deadline"
    t.integer "total_job_opportunities", null: false
    t.integer "status", default: 3, null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_job_opportunities_on_company_id"
  end

  create_table "refusal_responses", force: :cascade do |t|
    t.integer "refuser", default: 3
    t.text "reason"
    t.integer "job_application_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_application_id"], name: "index_refusal_responses_on_job_application_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "username"
    t.string "cpf"
    t.text "about_me"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidate_profiles", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "employee_profiles", "companies"
  add_foreign_key "employee_profiles", "users"
  add_foreign_key "job_applications", "candidate_profiles"
  add_foreign_key "job_applications", "job_opportunities"
  add_foreign_key "job_opportunities", "companies"
  add_foreign_key "refusal_responses", "job_applications"
end
