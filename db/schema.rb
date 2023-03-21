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

ActiveRecord::Schema[7.0].define(version: 2023_03_18_163410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "card_number", null: false
    t.integer "type_card", default: 0, null: false
    t.string "csv", null: false
    t.date "expiration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id", null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "billing_id"
    t.bigint "shipping_address_id"
    t.index ["billing_id"], name: "index_orders_on_billing_id"
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "api_url", default: 0, null: false
    t.string "external_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "stock", default: 0, null: false
    t.decimal "price", null: false
    t.string "images", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_url", "external_id"], name: "index_products_on_api_url_and_external_id", unique: true
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address", null: false
    t.string "country", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shipping_addresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "billings", "users"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "billings"
  add_foreign_key "orders", "shipping_addresses"
  add_foreign_key "orders", "users"
  add_foreign_key "shipping_addresses", "users"
end
