# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120403102840) do

  create_table "accounts", :force => true do |t|
    t.string   "account_number",                    :null => false
    t.string   "name",                              :null => false
    t.string   "mobile",         :default => "N.A"
    t.text     "address"
    t.string   "bank_name",      :default => "N.A"
    t.string   "branch_name",    :default => "N.A"
    t.string   "branch_code",    :default => "N.A"
    t.string   "micr_code",      :default => "N.A"
    t.string   "ifsc_code",      :default => "N.A"
    t.text     "remarks"
    t.boolean  "status",         :default => true
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", :force => true do |t|
    t.integer  "transaction_id"
    t.string   "account_number"
    t.string   "name"
    t.string   "branch_code"
    t.decimal  "amount",         :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "status",      :default => true
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "remarks"
    t.string   "transfer_account"
    t.string   "transfer_branch_code"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "status",                  :default => true
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                   :null => false
    t.string   "perishable_token",  :default => "",   :null => false
    t.integer  "login_count",       :default => 0,    :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "status",            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
