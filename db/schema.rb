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

ActiveRecord::Schema[7.1].define(version: 2024_01_01_022836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "outcomes", force: :cascade do |t|
    t.integer "result", null: false
    t.text "body", null: false
    t.bigint "prediction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prediction_id"], name: "index_outcomes_on_prediction_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.date "duedate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "predictor_id", null: false
    t.index ["predictor_id"], name: "index_predictions_on_predictor_id"
  end

  create_table "predictors", force: :cascade do |t|
    t.string "wikiurl", null: false
    t.string "title", null: false
    t.string "image"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wikiurl"], name: "index_predictors_on_wikiurl", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.integer "reason", null: false
    t.text "body", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reportable_type", null: false
    t.bigint "reportable_id", null: false
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "outcomes", "predictions"
  add_foreign_key "predictions", "predictors"
end
