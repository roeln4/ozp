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

ActiveRecord::Schema[7.0].define(version: 2022_12_05_194439) do
  create_table "answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "correct"
    t.integer "participant_id", null: false
    t.integer "face_id", null: false
    t.boolean "is_locked"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_answers_on_deleted_at"
    t.index ["face_id"], name: "index_answers_on_face_id"
    t.index ["participant_id"], name: "index_answers_on_participant_id"
  end

  create_table "faces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "url"
  end

  create_table "participants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.integer "age"
    t.string "current_study"
    t.json "progress"
    t.boolean "music_enabled"
    t.boolean "has_completed_training"
    t.datetime "deleted_at"
    t.string "comment"
    t.boolean "has_heard_music"
    t.integer "rating"
    t.text "feeling"
    t.json "questionnaire_progress"
    t.index ["deleted_at"], name: "index_participants_on_deleted_at"
  end

  add_foreign_key "answers", "faces"
  add_foreign_key "answers", "participants"
end
