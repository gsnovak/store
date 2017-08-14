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

ActiveRecord::Schema.define(version: 20170728140447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street_addr"
    t.string "city"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state_id"
    t.integer "zip_code"
    t.string "street_addr_2"
    t.string "name"
    t.index ["state_id"], name: "index_addresses_on_state_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.float "amount"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "state"
    t.string "coupon_type"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "month"
    t.string "year"
    t.string "last_four"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_type"
    t.integer "source_id"
    t.integer "quantity"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["source_type", "source_id"], name: "index_order_items_on_source_type_and_source_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.integer "credit_card_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["credit_card_id"], name: "index_payments_on_credit_card_id"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.boolean "available"
    t.integer "on_hand_count"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "state"
  end

  create_table "state_changes", force: :cascade do |t|
    t.string "previous_state"
    t.string "next_state"
    t.string "source_type"
    t.integer "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.index ["source_type", "source_id"], name: "index_state_changes_on_source_type_and_source_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.boolean "admin"
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
