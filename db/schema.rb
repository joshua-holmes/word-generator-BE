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

ActiveRecord::Schema.define(version: 2022_01_05_011157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fake_words", force: :cascade do |t|
    t.string "word"
  end

  create_table "favorite_words", force: :cascade do |t|
    t.integer "fake_word_id"
    t.integer "lexicon_id"
  end

  create_table "lexicon_words", force: :cascade do |t|
    t.integer "lexicon_id"
    t.integer "word_id"
  end

  create_table "lexicons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
  end

end
