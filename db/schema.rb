# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 2020_02_09_141233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.bigint "planed_expense_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["planed_expense_id"], name: "index_expenses_on_planed_expense_id"
  end

  create_table "finance_goals", force: :cascade do |t|
    t.integer "payment_amount", default: 0
    t.integer "income_amount", default: 0
    t.datetime "started_at", null: false
    t.datetime "finished_at", null: false
    t.bigint "moneybox_entry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["moneybox_entry_id"], name: "index_finance_goals_on_moneybox_entry_id"
  end

  create_table "moneybox_entries", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "balance", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_moneybox_entries_on_user_id"
  end

  create_table "planed_expenses", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.bigint "finance_goal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["finance_goal_id"], name: "index_planed_expenses_on_finance_goal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "expenses", "planed_expenses"
  add_foreign_key "finance_goals", "moneybox_entries", on_delete: :cascade
  add_foreign_key "moneybox_entries", "users", on_delete: :cascade
  add_foreign_key "planed_expenses", "finance_goals", on_delete: :cascade
end
