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

ActiveRecord::Schema.define(version: 2021_04_26_133054) do

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "groups", charset: "utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "base_address", default: "", null: false
    t.string "url", default: ""
    t.integer "group_category", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_groups_on_email", unique: true
    t.index ["reset_password_token"], name: "index_groups_on_reset_password_token", unique: true
  end

  create_table "impressions", charset: "utf8", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 255 }
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "join_volunteers", charset: "utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "phone_number"
    t.integer "number", null: false
    t.text "inquiry"
    t.string "joinable_type", null: false
    t.bigint "joinable_id", null: false
    t.bigint "volunteer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["joinable_type", "joinable_id"], name: "index_join_volunteers_on_joinable"
    t.index ["volunteer_id"], name: "index_join_volunteers_on_volunteer_id"
  end

  create_table "notifications", charset: "utf8", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "action", null: false
    t.boolean "checked", default: false, null: false
    t.bigint "join_volunteer_id"
    t.string "sendable_type", null: false
    t.bigint "sendable_id", null: false
    t.string "receiveable_type", null: false
    t.bigint "receiveable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["join_volunteer_id"], name: "index_notifications_on_join_volunteer_id"
    t.index ["receiveable_type", "receiveable_id"], name: "index_notifications_on_receiveable"
    t.index ["sendable_type", "sendable_id"], name: "index_notifications_on_sendable"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteers", charset: "utf8", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "place", default: "", null: false
    t.text "details"
    t.date "schedule", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "expenses", default: ""
    t.string "conditions", default: ""
    t.integer "application_people", null: false
    t.date "deadline", null: false
    t.integer "participant_number", default: 0
    t.boolean "contributor_flag", default: false, null: false
    t.string "postable_type", null: false
    t.bigint "postable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["postable_type", "postable_id"], name: "index_volunteers_on_postable"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "join_volunteers", "volunteers"
  add_foreign_key "notifications", "join_volunteers"
end
