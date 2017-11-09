# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20171108235605) do
=======
ActiveRecord::Schema.define(version: 20171108231037) do
>>>>>>> bce817b643297b1577270dc2dc0a878aa870f61b

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loans", force: :cascade do |t|
    t.integer "amount_in_cents"
    t.string "body"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
<<<<<<< HEAD
    t.integer "lender_id"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
=======
    t.integer "borrower_id"
    t.integer "lender_id"
>>>>>>> bce817b643297b1577270dc2dc0a878aa870f61b
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "role"
  end

end
