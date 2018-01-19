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

ActiveRecord::Schema.define(version: 20180116202442) do

  create_table "checkouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.string "image_url", null: false
    t.string "type", default: "Product", null: false
    t.decimal "base_price", precision: 8, scale: 2, null: false
    t.string "base_currency", default: "EUR", null: false
    t.string "barcode_number", null: false
    t.integer "num_to_buy"
    t.integer "num_will_get"
    t.integer "bulk_threshold"
    t.decimal "bulk_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "product_id", null: false
    t.bigint "checkout_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkout_id"], name: "index_scans_on_checkout_id"
    t.index ["product_id"], name: "index_scans_on_product_id"
  end

  add_foreign_key "scans", "checkouts"
  add_foreign_key "scans", "products"
end
