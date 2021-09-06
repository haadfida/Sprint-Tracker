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

ActiveRecord::Schema.define(version: 2021_09_03_201741) do

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_companies_on_owner_id"
    t.index ["subdomain"], name: "index_companies_on_subdomain"
  end

  create_table "issues", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "status", null: false
    t.string "priority", null: false
    t.string "category", null: false
    t.bigint "company_id", null: false
    t.date "estimated_start_date", null: false
    t.date "actual_start_date"
    t.date "estimated_end_date", null: false
    t.date "actual_end_date"
    t.integer "creator_id"
    t.string "assignee_id"
    t.integer "reviewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["assignee_id"], name: "index_issues_on_assignee_id"
    t.index ["category"], name: "index_issues_on_category"
    t.index ["company_id"], name: "index_issues_on_company_id"
    t.index ["creator_id"], name: "index_issues_on_creator_id"
    t.index ["priority"], name: "index_issues_on_priority"
    t.index ["reviewer_id"], name: "index_issues_on_reviewer_id"
    t.index ["sequence_num", "company_id"], name: "index_issues_on_sequence_num_and_company_id", unique: true
    t.index ["status"], name: "index_issues_on_status"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "manager_id", null: false
    t.bigint "owner_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["manager_id"], name: "index_projects_on_manager_id"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "phone_num"
    t.bigint "company_id", default: 0
    t.integer "sequence_num", null: false
    t.integer "role_id"
    t.index ["company_id", "email"], name: "index_users_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sequence_num", "company_id"], name: "index_users_on_sequence_num_and_company_id", unique: true
  end

  add_foreign_key "companies", "users", column: "owner_id"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "users", column: "manager_id"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "users", "companies"
end