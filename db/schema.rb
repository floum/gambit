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

ActiveRecord::Schema[7.2].define(version: 2025_08_07_143558) do
  create_table "game_moves", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "move_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_moves_on_game_id"
    t.index ["move_id"], name: "index_game_moves_on_move_id"
  end

  create_table "game_review_moves", force: :cascade do |t|
    t.integer "game_review_id", null: false
    t.integer "move_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_review_id"], name: "index_game_review_moves_on_game_review_id"
    t.index ["move_id"], name: "index_game_review_moves_on_move_id"
  end

  create_table "game_reviews", force: :cascade do |t|
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_reviews_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "result"
    t.string "white"
    t.string "black"
    t.string "site"
    t.boolean "review_as_white"
    t.integer "review_size"
  end

  create_table "moves", force: :cascade do |t|
    t.string "before", null: false
    t.string "after", null: false
    t.string "uci", null: false
    t.string "san", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repertoire_move_attempts", force: :cascade do |t|
    t.boolean "success"
    t.integer "repertoire_move_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repertoire_move_id"], name: "index_repertoire_move_attempts_on_repertoire_move_id"
  end

  create_table "repertoire_moves", force: :cascade do |t|
    t.integer "move_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["move_id"], name: "index_move_on_move_id"
  end

  create_table "repertoires", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "white", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_moves", "games"
  add_foreign_key "game_moves", "moves"
  add_foreign_key "game_review_moves", "game_reviews"
  add_foreign_key "game_review_moves", "moves"
  add_foreign_key "game_reviews", "games"
  add_foreign_key "repertoire_move_attempts", "repertoire_moves"
end
