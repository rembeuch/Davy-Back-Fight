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

ActiveRecord::Schema.define(version: 2021_08_10_140910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.string "text"
    t.integer "position"
    t.integer "multiplier"
    t.string "status", default: "En cours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "link"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "fight_tokens", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enemy_id"], name: "index_fight_tokens_on_enemy_id"
    t.index ["player_id"], name: "index_fight_tokens_on_player_id"
  end

  create_table "islands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "category"
    t.integer "difficulty", default: 1
    t.string "condition", default: ""
    t.integer "position", default: 0
  end

  create_table "items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_items_on_cart_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "mobs", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.bigint "place_id"
    t.integer "health"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "bonus"
    t.integer "exp"
    t.integer "power"
    t.string "condition"
    t.string "category", default: ""
    t.index ["place_id"], name: "index_mobs_on_place_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.string "product_name"
    t.float "amount_cents", default: 0.0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "city"
    t.integer "zipcode"
    t.string "nation"
    t.integer "quantity", default: 1
    t.string "coupon"
    t.string "name"
    t.boolean "mailing", default: true
    t.boolean "upsell", default: false
    t.string "tel"
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Validée"
    t.string "answer", default: "En attente"
    t.integer "lap", default: 1
    t.boolean "engage", default: false
    t.index ["tournament_id"], name: "index_participations_on_tournament_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.bigint "island_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "condition"
    t.index ["island_id"], name: "index_places_on_island_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.integer "health", default: 3
    t.integer "level", default: 1
    t.integer "exp", default: 0
    t.integer "action", default: 3
    t.boolean "in_fight", default: false
    t.integer "mob_power"
    t.integer "player_power", default: 0
    t.string "fight", default: "default"
    t.integer "max_health", default: 3
    t.integer "mob_health"
    t.string "in_fight_enemy", default: ""
    t.string "in_fight_mob", default: ""
    t.string "defeated_mob", default: [], array: true
    t.integer "money", default: 0
    t.boolean "captain", default: false
    t.string "crew", default: ""
    t.boolean "open_crew", default: false
    t.string "visited_island", default: [], array: true
    t.string "visited_place", default: [], array: true
    t.integer "wanted", default: 0
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.text "description"
    t.string "tags", default: ""
    t.string "image"
    t.text "carousel", default: [], array: true
  end

  create_table "quest_logs", force: :cascade do |t|
    t.bigint "player_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_quest_logs_on_player_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "photo"
    t.string "tag"
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lock", default: false
    t.string "image", default: ""
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.boolean "status", default: false
    t.index ["quiz_id"], name: "index_quiz_answers_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question"
    t.integer "numero"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "mob_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "category"
    t.string "image"
    t.string "statut", default: "Non équipé"
    t.integer "price", default: 0
    t.index ["mob_id"], name: "index_rewards_on_mob_id"
    t.index ["player_id"], name: "index_rewards_on_player_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "à venir"
    t.string "title"
    t.datetime "start"
    t.integer "lap", default: 1
  end

  create_table "user_answers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "answer_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "closed", default: false
    t.index ["answer_id"], name: "index_user_answers_on_answer_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pseudo"
    t.string "avatar", default: ""
    t.integer "berrys", default: 10000
    t.boolean "admin"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "numero_quiz", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "carts", "users"
  add_foreign_key "fight_tokens", "players"
  add_foreign_key "fight_tokens", "players", column: "enemy_id"
  add_foreign_key "items", "carts"
  add_foreign_key "items", "products"
  add_foreign_key "mobs", "places"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "participations", "tournaments"
  add_foreign_key "participations", "users"
  add_foreign_key "places", "islands"
  add_foreign_key "players", "users"
  add_foreign_key "quest_logs", "players"
  add_foreign_key "quiz_answers", "quizzes"
  add_foreign_key "rewards", "mobs"
  add_foreign_key "rewards", "players"
  add_foreign_key "user_answers", "answers"
  add_foreign_key "user_answers", "users"
end
