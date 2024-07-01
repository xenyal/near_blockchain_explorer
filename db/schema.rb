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

ActiveRecord::Schema[7.1].define(version: 2024_07_01_022024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "block_transaction_id", null: false
    t.string "type", null: false
    t.json "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_transaction_id"], name: "index_actions_on_block_transaction_id"
    t.index ["type"], name: "index_actions_on_type"
  end

  create_table "block_transactions", force: :cascade do |t|
    t.bigint "block_id", null: false
    t.string "transaction_hash", null: false
    t.string "sender", null: false
    t.string "receiver", null: false
    t.bigint "gas_burnt", null: false
    t.integer "actions_count", null: false
    t.boolean "success", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_block_transactions_on_block_id"
    t.index ["gas_burnt"], name: "index_block_transactions_on_gas_burnt"
    t.index ["transaction_hash"], name: "index_block_transactions_on_transaction_hash", unique: true
  end

  create_table "blockchains", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "avg_gas_burnt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocks", force: :cascade do |t|
    t.bigint "blockchain_id", null: false
    t.string "block_id", null: false
    t.bigint "height", null: false
    t.string "block_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "time", null: false
    t.index ["block_hash"], name: "index_blocks_on_block_hash", unique: true
    t.index ["blockchain_id"], name: "index_blocks_on_blockchain_id"
    t.index ["created_at"], name: "index_blocks_on_created_at"
  end

  add_foreign_key "actions", "block_transactions"
  add_foreign_key "block_transactions", "blocks"
  add_foreign_key "blocks", "blockchains"
end
