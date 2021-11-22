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

ActiveRecord::Schema.define(version: 2021_11_22_122148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.integer "balance"
    t.string "role"
    t.string "public_id"
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "auth_identities", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.string "token"
    t.string "login"
    t.bigint "accounts_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accounts_id"], name: "index_auth_identities_on_accounts_id"
  end

  create_table "billing_cycles", force: :cascade do |t|
    t.string "status"
    t.string "period"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_billing_cycles_on_account_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "amount"
    t.string "status"
    t.bigint "transactions_id", null: false
    t.bigint "billing_cycles_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_cycles_id"], name: "index_payments_on_billing_cycles_id"
    t.index ["transactions_id"], name: "index_payments_on_transactions_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "description"
    t.string "cost"
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "type"
    t.jsonb "data"
    t.string "entry"
    t.uuid "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "auth_identities", "accounts", column: "accounts_id"
  add_foreign_key "billing_cycles", "accounts"
  add_foreign_key "payments", "billing_cycles", column: "billing_cycles_id"
  add_foreign_key "payments", "transactions", column: "transactions_id"
end
