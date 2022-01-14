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

ActiveRecord::Schema.define(version: 2021_09_27_075550) do

  create_table "audits", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.json "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.bigint "company_id", null: false
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_companies_on_owner_id"
    t.index ["subdomain"], name: "index_companies_on_subdomain"
  end

  create_table "delayed_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "issues", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "estimated_time", precision: 10, scale: 2
    t.string "status", null: false
    t.string "priority", null: false
    t.string "category", null: false
    t.bigint "company_id", null: false
    t.datetime "estimated_start_date"
    t.datetime "actual_start_date"
    t.datetime "estimated_end_date"
    t.datetime "actual_end_date"
    t.integer "creator_id"
    t.string "assignee_id"
    t.integer "reviewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.bigint "project_id"
    t.bigint "sprint_id"
    t.index ["assignee_id"], name: "index_issues_on_assignee_id"
    t.index ["category"], name: "index_issues_on_category"
    t.index ["company_id"], name: "index_issues_on_company_id"
    t.index ["creator_id"], name: "index_issues_on_creator_id"
    t.index ["priority"], name: "index_issues_on_priority"
    t.index ["project_id"], name: "index_issues_on_project_id"
    t.index ["reviewer_id"], name: "index_issues_on_reviewer_id"
    t.index ["sequence_num", "company_id"], name: "index_issues_on_sequence_num_and_company_id", unique: true
    t.index ["sprint_id"], name: "index_issues_on_sprint_id"
    t.index ["status"], name: "index_issues_on_status"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "manager_id", null: false
    t.bigint "creator_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.bigint "active_sprint_id"
    t.index ["active_sprint_id"], name: "index_projects_on_active_sprint_id"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["creator_id"], name: "index_projects_on_creator_id"
    t.index ["manager_id"], name: "index_projects_on_manager_id"
  end

  create_table "projects_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_projects_users_on_company_id"
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "sprintreports", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "sprint_id", null: false
    t.bigint "moved_to_id"
    t.string "status"
    t.bigint "issue_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_sprintreports_on_company_id"
    t.index ["issue_id"], name: "index_sprintreports_on_issue_id"
    t.index ["moved_to_id"], name: "index_sprintreports_on_moved_to_id"
    t.index ["sprint_id"], name: "index_sprintreports_on_sprint_id"
  end

  create_table "sprints", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "estimated_start_date"
    t.datetime "estimated_end_date"
    t.integer "sequence_num", null: false
    t.bigint "project_id", null: false
    t.bigint "company_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "PLANNING"
    t.index ["company_id"], name: "index_sprints_on_company_id"
    t.index ["creator_id"], name: "index_sprints_on_creator_id"
    t.index ["project_id"], name: "index_sprints_on_project_id"
    t.index ["sequence_num"], name: "index_sprints_on_sequence_num"
  end

  create_table "time_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date"
    t.decimal "logged_time", precision: 10, scale: 2, null: false
    t.text "work_description", null: false
    t.bigint "company_id", null: false
    t.bigint "issue_id", null: false
    t.bigint "assignee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["assignee_id"], name: "index_time_logs_on_assignee_id"
    t.index ["company_id"], name: "index_time_logs_on_company_id"
    t.index ["issue_id"], name: "index_time_logs_on_issue_id"
    t.index ["sequence_num", "issue_id"], name: "index_time_logs_on_sequence_num_and_issue_id", unique: true
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
    t.string "phone_num"
    t.bigint "company_id"
    t.integer "sequence_num", null: false
    t.integer "role_id"
    t.string "confirmation_token"
    t.string "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["company_id", "email"], name: "index_users_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sequence_num", "company_id"], name: "index_users_on_sequence_num_and_company_id", unique: true
  end

  add_foreign_key "companies", "users", column: "owner_id"
  add_foreign_key "issues", "projects"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "users", column: "creator_id"
  add_foreign_key "projects", "users", column: "manager_id"
  add_foreign_key "projects_users", "companies"
  add_foreign_key "projects_users", "projects"
  add_foreign_key "projects_users", "users"
  add_foreign_key "sprintreports", "companies"
  add_foreign_key "sprints", "companies"
  add_foreign_key "sprints", "projects"
  add_foreign_key "sprints", "users", column: "creator_id"
  add_foreign_key "time_logs", "companies"
  add_foreign_key "time_logs", "issues"
  add_foreign_key "time_logs", "users", column: "assignee_id"
  add_foreign_key "users", "companies"
end
