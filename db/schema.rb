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

ActiveRecord::Schema[7.0].define(version: 2023_07_19_023112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "product_id", null: false
    t.decimal "unit_cost", precision: 12, scale: 2
    t.integer "quantity"
    t.decimal "total_cost", precision: 12, scale: 2
    t.decimal "total_seller_price", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "seller_id", null: false
    t.uuid "customer_id", null: false
    t.uuid "city_id", null: false
    t.uuid "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_orders_on_city_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["seller_id"], name: "index_orders_on_seller_id"
    t.index ["state_id"], name: "index_orders_on_state_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "cost", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_states_on_city_id"
  end

  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "cities"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "sellers"
  add_foreign_key "orders", "states"
  add_foreign_key "states", "cities"
end
