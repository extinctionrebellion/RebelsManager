# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_15_071230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "starts_at"
    t.string "ends_at"
    t.string "facebook_url"
    t.bigint "local_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_group_id"], name: "index_events_on_local_group_id"
  end

  create_table "local_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "mailtrain_list_id"
  end

  create_table "rebel_skills", force: :cascade do |t|
    t.bigint "rebel_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rebel_id"], name: "index_rebel_skills_on_rebel_id"
    t.index ["skill_id"], name: "index_rebel_skills_on_skill_id"
  end

  create_table "rebels", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "irl"
    t.bigint "local_group_id"
    t.boolean "consent"
    t.text "tags"
    t.string "language"
    t.string "postcode"
    t.string "interests"
    t.text "internal_notes"
    t.string "status"
    t.string "source"
    t.boolean "willingness_to_be_arrested"
    t.string "token"
    t.datetime "self_updated_at"
    t.string "availability"
    t.integer "number_of_arrests"
    t.string "email_ciphertext"
    t.string "email_bidx"
    t.string "phone_ciphertext"
    t.string "phone_bidx"
    t.boolean "agree_with_principles"
    t.index ["email_bidx"], name: "index_rebels_on_email_bidx", unique: true
    t.index ["local_group_id"], name: "index_rebels_on_local_group_id"
    t.index ["phone_bidx"], name: "index_rebels_on_phone_bidx"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "local_group_id"
    t.boolean "admin"
    t.string "otp_auth_secret"
    t.string "otp_recovery_secret"
    t.boolean "otp_enabled", default: false, null: false
    t.boolean "otp_mandatory", default: false, null: false
    t.datetime "otp_enabled_on"
    t.integer "otp_failed_attempts", default: 0, null: false
    t.integer "otp_recovery_counter", default: 0, null: false
    t.string "otp_persistence_seed"
    t.string "otp_session_challenge"
    t.datetime "otp_challenge_expires"
    t.string "email_ciphertext"
    t.string "email_bidx"
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["local_group_id"], name: "index_users_on_local_group_id"
    t.index ["otp_challenge_expires"], name: "index_users_on_otp_challenge_expires"
    t.index ["otp_session_challenge"], name: "index_users_on_otp_session_challenge", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "working_group_enrollments", force: :cascade do |t|
    t.bigint "rebel_id", null: false
    t.bigint "working_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rebel_id"], name: "index_working_group_enrollments_on_rebel_id"
    t.index ["working_group_id"], name: "index_working_group_enrollments_on_working_group_id"
  end

  create_table "working_groups", force: :cascade do |t|
    t.bigint "local_group_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color"
    t.string "code"
    t.index ["local_group_id"], name: "index_working_groups_on_local_group_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "rebel_skills", "rebels"
  add_foreign_key "rebel_skills", "skills"
  add_foreign_key "rebels", "local_groups"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "local_groups"
  add_foreign_key "working_group_enrollments", "rebels"
  add_foreign_key "working_group_enrollments", "working_groups"
  add_foreign_key "working_groups", "local_groups"
end
