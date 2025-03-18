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

ActiveRecord::Schema[8.0].define(version: 2025_03_13_071826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "compartilhamento_listas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lista_compra_id", null: false
    t.string "permissao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lista_compra_id"], name: "index_compartilhamento_listas_on_lista_compra_id"
    t.index ["user_id"], name: "index_compartilhamento_listas_on_user_id"
  end

  create_table "item_lista", force: :cascade do |t|
    t.string "nome_item"
    t.integer "quantidade"
    t.text "observacoes"
    t.bigint "lista_compra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lista_compra_id"], name: "index_item_lista_on_lista_compra_id"
  end

  create_table "lista_compras", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lista_compras_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "compartilhamento_listas", "lista_compras"
  add_foreign_key "compartilhamento_listas", "users"
  add_foreign_key "item_lista", "lista_compras"
  add_foreign_key "lista_compras", "users"
end
