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

ActiveRecord::Schema.define(version: 2019_09_07_020604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "addr1"
    t.string "addr2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "hash_id"
    t.jsonb "settings", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_id"], name: "index_accounts_on_hash_id"
    t.index ["settings"], name: "index_accounts_on_settings", using: :gin
  end

  create_table "days_of_the_week_memberships", force: :cascade do |t|
    t.bigint "team_id"
    t.integer "day"
    t.index ["team_id"], name: "index_days_of_the_week_memberships_on_team_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "standups", force: :cascade do |t|
    t.bigint "user_id"
    t.date "standup_date"
    t.string "hash_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message_id"
    t.index ["message_id"], name: "index_standups_on_message_id"
    t.index ["user_id"], name: "index_standups_on_user_id"
  end

  create_table "stripe_webhooks", force: :cascade do |t|
    t.string "stripe_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_event_id"], name: "index_stripe_webhooks_on_stripe_event_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "account_id"
    t.string "plan_id"
    t.string "stripe_customer_id"
    t.datetime "start"
    t.string "status"
    t.string "stripe_subscription_id"
    t.string "stripe_token"
    t.string "card_last4"
    t.string "card_expiration"
    t.string "card_type"
    t.string "stripe_status"
    t.string "idempotency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_subscriptions_on_account_id"
  end

  create_table "task_memberships", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "standup_id"
    t.index ["standup_id"], name: "index_task_memberships_on_standup_id"
    t.index ["task_id"], name: "index_task_memberships_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.boolean "is_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id"
    t.string "timezone"
    t.boolean "has_reminder"
    t.boolean "has_recap"
    t.string "hash_id"
    t.time "reminder_time"
    t.time "recap_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["account_id"], name: "index_teams_on_account_id"
    t.index ["has_recap", "recap_time"], name: "index_teams_on_has_recap_and_recap_time"
    t.index ["has_reminder", "reminder_time"], name: "index_teams_on_has_reminder_and_reminder_time"
    t.index ["hash_id"], name: "index_teams_on_hash_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.string "time_zone"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.bigint "account_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hash_id"], name: "index_users_on_hash_id"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "days_of_the_week_memberships", "teams"
  add_foreign_key "standups", "users"
  add_foreign_key "subscriptions", "accounts"
  add_foreign_key "task_memberships", "standups"
  add_foreign_key "task_memberships", "tasks"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "teams", "accounts"
  add_foreign_key "users", "accounts"
end
