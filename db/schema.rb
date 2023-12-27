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

ActiveRecord::Schema[7.1].define(version: 2023_12_27_042049) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "outcomes", force: :cascade do |t|
    t.integer "result"
    t.text "body"
    t.bigint "prediction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prediction_id"], name: "index_outcomes_on_prediction_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.date "duedate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "predictor_id", null: false
    t.index ["predictor_id"], name: "index_predictions_on_predictor_id"
  end

  create_table "predictors", force: :cascade do |t|
    t.string "wikiurl"
    t.string "title"
    t.string "image"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "reason"
    t.text "body"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reportable_type", null: false
    t.bigint "reportable_id", null: false
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable"
  end

  add_foreign_key "outcomes", "predictions"
  add_foreign_key "predictions", "predictors"
end
