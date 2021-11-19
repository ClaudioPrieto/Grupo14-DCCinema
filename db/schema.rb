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

ActiveRecord::Schema.define(version: 2021_11_19_031317) do

  create_table "movie_instances", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "room_id", null: false
    t.date "day"
    t.string "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_instances_on_movie_id"
    t.index ["room_id"], name: "index_movie_instances_on_room_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "movie_instance_id", null: false
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_instance_id"], name: "index_reservations_on_movie_instance_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer "reservation_id", null: false
    t.string "column"
    t.string "row"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_seats_on_reservation_id"
  end

  add_foreign_key "movie_instances", "movies"
  add_foreign_key "movie_instances", "rooms"
  add_foreign_key "reservations", "movie_instances"
  add_foreign_key "seats", "reservations"
end
