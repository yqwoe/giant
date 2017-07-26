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

ActiveRecord::Schema.define(version: 20170726102916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "ads", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "car_brands", id: :serial, force: :cascade do |t|
    t.string "en_name"
    t.string "cn_name"
    t.string "shor_name"
    t.string "img_url"
    t.string "manufacture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "initial_letter"
  end

  create_table "car_models", id: :serial, force: :cascade do |t|
    t.integer "car_brand_id"
    t.string "cn_name"
    t.string "en_name"
    t.string "initial_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", id: :serial, force: :cascade do |t|
    t.string "cid"
    t.string "pin"
    t.integer "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "actived_at"
    t.integer "car_id"
    t.integer "range"
    t.integer "channel"
    t.integer "growing_user_id"
  end

  create_table "cars", id: :serial, force: :cascade do |t|
    t.integer "car_model_id"
    t.string "licensed_id"
    t.integer "status"
    t.date "joined_at"
    t.date "visited_at"
    t.integer "user_id"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "valid_at"
    t.string "vin"
    t.string "engine_no"
    t.index ["licensed_id"], name: "index_cars_on_licensed_id", unique: true
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.integer "seller_id"
    t.integer "second_seller_id"
    t.integer "custom_id"
    t.float "commission_portion", default: 0.0
    t.float "second_commission_portion", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_id"], name: "index_clients_on_custom_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "content"
    t.integer "env_star"
    t.integer "service_star"
    t.integer "clean_star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deal_id"
    t.integer "shop_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  end

  create_table "coupons", id: :serial, force: :cascade do |t|
    t.string "avatar"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "deductible"
  end

  create_table "deals", id: :serial, force: :cascade do |t|
    t.integer "car_id"
    t.integer "shop_id"
    t.datetime "visited_at"
    t.datetime "cleaned_at"
    t.integer "status"
    t.datetime "commented_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "comment_id"
    t.string "avatar"
    t.datetime "deleted_at"
    t.string "memo"
    t.index ["deleted_at"], name: "index_deals_on_deleted_at"
  end

  create_table "devices", id: :serial, force: :cascade do |t|
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices_and_users_relationships", id: :serial, force: :cascade do |t|
    t.integer "device_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id", "user_id"], name: "index_devices_and_users_relationships_on_device_id_and_user_id", unique: true
  end

  create_table "growing_cards", id: :serial, force: :cascade do |t|
    t.string "cid"
    t.string "pin"
    t.float "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cid"], name: "index_growing_cards_on_cid", unique: true
    t.index ["pin"], name: "index_growing_cards_on_pin", unique: true
  end

  create_table "growing_users", id: :serial, force: :cascade do |t|
    t.string "mobile"
    t.integer "growing_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.boolean "enrolled_520"
    t.index ["mobile"], name: "index_growing_users_on_mobile", unique: true
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "msg_id"
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "state"
    t.integer "payment_gateway"
    t.float "price"
    t.integer "quantity"
    t.float "distcount"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "platform"
    t.float "total_amount"
    t.string "body"
    t.datetime "finished_at"
    t.datetime "canceled_at"
    t.integer "status"
    t.integer "car_id"
    t.string "trade_no"
  end

  create_table "phones", id: :serial, force: :cascade do |t|
    t.string "phone"
    t.string "pin"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plates", force: :cascade do |t|
    t.string "licensed_id"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_cities", id: :serial, force: :cascade do |t|
    t.string "province"
    t.string "city"
    t.float "center"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
  end

  create_table "shops", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "city"
    t.integer "star"
    t.string "category"
    t.string "address"
    t.daterange "duration"
    t.integer "status", default: 1
    t.string "profile"
    t.string "services"
    t.string "sale_content"
    t.string "province"
    t.string "county"
    t.string "position", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", default: "default_shop.png"
    t.integer "user_id"
    t.string "openning"
    t.datetime "deleted_at"
    t.string "detail_images", array: true
    t.float "lat"
    t.float "lng"
    t.string "short_name"
    t.index "ll_to_earth(((\"position\"[1])::real)::double precision, ((\"position\"[2])::real)::double precision)", name: "shops_earthdistance_ix", using: :gist
    t.index ["deleted_at"], name: "index_shops_on_deleted_at"
  end

  create_table "suite_orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "state"
    t.integer "payment_gateway"
    t.float "price"
    t.integer "quantity"
    t.integer "suite_id"
    t.integer "coupon_id"
    t.integer "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trade_no"
    t.index ["coupon_id"], name: "index_suite_orders_on_coupon_id"
    t.index ["suite_id"], name: "index_suite_orders_on_suite_id"
  end

  create_table "suites", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "origin_price"
    t.float "sale_price"
    t.integer "store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.integer "tags"
    t.string "avatar"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "mobile"
    t.string "access_token"
    t.string "pin"
    t.boolean "verified"
    t.string "authentication_token"
    t.integer "roles", default: 0
    t.string "invitation_token"
    t.integer "invited_by"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile"], name: "index_users_on_mobile", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "number"
    t.string "download_url"
    t.string "contents", array: true
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "package_size"
  end

  create_table "violations", id: :serial, force: :cascade do |t|
    t.integer "car_id"
    t.datetime "vio_date"
    t.string "address"
    t.integer "penalty"
    t.string "legal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fine"
  end

  create_table "wares", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "origin_price"
    t.float "sale_price"
    t.string "avatar"
    t.string "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "suite_id"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
