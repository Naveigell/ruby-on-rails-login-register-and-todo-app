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

ActiveRecord::Schema.define(version: 2021_01_10_065558) do

  create_table "todo", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title", limit: 30, null: false
    t.string "description", null: false
  end

  create_table "users", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "username", limit: 40, null: false
    t.string "email", null: false
    t.string "password", null: false
    t.column "role", "enum('admin','user')", default: "admin", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
