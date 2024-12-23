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

ActiveRecord::Schema[7.2].define(version: 2024_11_16_153631) do
  create_table "move_counts", force: :cascade do |t|
    t.integer "move_id", null: false
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["move_id"], name: "index_move_counts_on_move_id"
  end

  create_table "moves", force: :cascade do |t|
    t.integer "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uci"
    t.string "san"
    t.integer "result_id", null: true
    t.integer "count"
    t.index ["position_id"], name: "index_moves_on_position_id"
    t.index ["result_id"], name: "index_moves_on_result_id"
  end

  create_table "position_counts", force: :cascade do |t|
    t.integer "position_id", null: false
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_position_counts_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "fen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
  end

  create_table "repertoire_moves", force: :cascade do |t|
    t.integer "move_id", null: false
    t.integer "repertoire_position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["move_id"], name: "index_repertoire_moves_on_move_id"
    t.index ["repertoire_position_id"], name: "index_repertoire_moves_on_repertoire_position_id"
  end

  create_table "repertoire_positions", force: :cascade do |t|
    t.integer "repertoire_id", null: false
    t.integer "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_repertoire_positions_on_position_id"
    t.index ["repertoire_id"], name: "index_repertoire_positions_on_repertoire_id"
  end

  create_table "repertoires", force: :cascade do |t|
    t.integer "precision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "white"
  end

  add_foreign_key "move_counts", "moves"
  add_foreign_key "moves", "positions"
  add_foreign_key "moves", "positions", column: "result_id"
  add_foreign_key "position_counts", "positions"
  add_foreign_key "repertoire_moves", "moves"
  add_foreign_key "repertoire_moves", "repertoire_positions"
  add_foreign_key "repertoire_positions", "positions"
  add_foreign_key "repertoire_positions", "repertoires"
end
