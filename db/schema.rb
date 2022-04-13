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

ActiveRecord::Schema.define(version: 2022_04_13_162400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "active_storage_data", force: :cascade do |t|
    t.string "key", null: false
    t.binary "io", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_active_storage_data_on_key"
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "affected_units", force: :cascade do |t|
    t.string "unit_code"
    t.string "assessment_type"
    t.date "date_from"
    t.date "date_to"
    t.string "requested_action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ecf_id"
    t.index ["ecf_id"], name: "index_affected_units_on_ecf_id"
  end

  create_table "agendas", force: :cascade do |t|
    t.integer "ecf_id"
    t.integer "meeting_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "decisions", force: :cascade do |t|
    t.string "module_code"
    t.string "requested_action"
    t.string "outcome"
    t.date "extension_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "agenda_id"
    t.string "assessment_type"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "ecf_notes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ecf_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 3
  end

  create_table "ecfs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "status"
    t.date "date"
    t.boolean "is_serious_short_term"
    t.boolean "is_deterioration_of_disability"
    t.boolean "is_bereavement"
    t.boolean "is_significant_adverse_personal"
    t.boolean "is_frequent_absence"
    t.string "details"
    t.date "start_of_circumstances"
    t.date "end_of_circumstances"
    t.boolean "is_ongoing"
    t.boolean "is_other_exceptional_factors"
    t.integer "user_id"
    t.boolean "highly_sensitive"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attendees"
    t.datetime "time"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cas_ticket"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "user_modules", force: :cascade do |t|
    t.string "user_id"
    t.string "module_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.integer "role", default: 0
    t.integer "registration_number"
    t.boolean "is_student_visa"
    t.string "programme_of_study"
    t.string "level_of_study"
    t.string "signature"
    t.date "dob"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ecf_notes", "ecfs"
  add_foreign_key "ecf_notes", "users"
  add_foreign_key "ecfs", "users"
end
