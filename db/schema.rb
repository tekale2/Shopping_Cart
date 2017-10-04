# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171004143554) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode", null: false
  end

  create_table "customer_addresses", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "address_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name",    null: false
    t.string "email",   null: false
    t.string "contact", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string  "name",        null: false
    t.text    "description"
    t.integer "price",       null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "quantity",       null: false
    t.integer "totalItemPrice"
  end

  create_table "orders", force: :cascade do |t|
    t.date    "placedOn",    null: false
    t.integer "customer_id"
    t.integer "address_id"
    t.integer "payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string  "cvv",         null: false
    t.string  "cardNo",      null: false
    t.string  "cardType",    null: false
    t.date    "expiry",      null: false
    t.integer "customer_id"
  end

end
