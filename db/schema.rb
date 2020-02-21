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

ActiveRecord::Schema.define(version: 2020_02_20_140836) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "duration"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.boolean "paid", default: false
    t.boolean "confirmed", default: false
    t.boolean "validated", default: false
    t.bigint "problem_seeker_id"
    t.bigint "problem_solver_id"
    t.bigint "mission_id"
    t.index ["mission_id"], name: "index_appointments_on_mission_id"
    t.index ["problem_seeker_id"], name: "index_appointments_on_problem_seeker_id"
    t.index ["problem_solver_id"], name: "index_appointments_on_problem_solver_id"
  end

  create_table "categorytags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "problem_description"
    t.string "image_url"
  end

  create_table "device_categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "link_device_to_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "device_category_id"
    t.integer "level", default: 0
    t.boolean "acquired", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_category_id"], name: "index_link_device_to_users_on_device_category_id"
    t.index ["user_id"], name: "index_link_device_to_users_on_user_id"
  end

  create_table "link_skill_to_users", force: :cascade do |t|
    t.integer "level", default: 0
    t.boolean "acquired", default: false
    t.bigint "user_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_link_skill_to_users_on_skill_id"
    t.index ["user_id"], name: "index_link_skill_to_users_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "recipient_id"
    t.bigint "sender_id"
    t.text "content"
    t.string "object"
    t.string "mission_url"
    t.boolean "already_read", default: false
    t.boolean "sender_deleted", default: false
    t.boolean "recipient_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "price"
    t.integer "rate"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "postal_code"
    t.string "country"
    t.string "city"
    t.boolean "solved", default: false
    t.boolean "phone_contact", default: false
    t.boolean "email_contact", default: false
    t.boolean "in_person_help", default: false
    t.boolean "remote_help", default: false
    t.bigint "device_category_id"
    t.bigint "user_id"
    t.bigint "categorytag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorytag_id"], name: "index_missions_on_categorytag_id"
    t.index ["device_category_id"], name: "index_missions_on_device_category_id"
    t.index ["user_id"], name: "index_missions_on_user_id"
  end

  create_table "problemtypes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "assessor_id"
    t.bigint "assessed_id"
    t.string "content"
    t.integer "rate", default: 3
    t.bigint "mission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessed_id"], name: "index_reviews_on_assessed_id"
    t.index ["assessor_id"], name: "index_reviews_on_assessor_id"
    t.index ["mission_id"], name: "index_reviews_on_mission_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "categorytag_id"
    t.index ["categorytag_id"], name: "index_skills_on_categorytag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "Utlisateur"
    t.string "last_name", default: "Utlisateur"
    t.float "latitude"
    t.float "longitude"
    t.string "address", default: "5 Parvis Alan Turing, Paris, France"
    t.string "postal_code"
    t.string "country"
    t.string "city"
    t.string "facebook_uid"
    t.string "phone_number"
    t.text "description"
    t.integer "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "service_provider", default: false
    t.boolean "status_activity", default: true
    t.integer "solved_mission_number", default: 0
    t.float "global_review_mark", default: 0.0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
