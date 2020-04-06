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

ActiveRecord::Schema.define(version: 2020_04_05_211146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "storage_dns_records", force: :cascade do |t|
    t.string "ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "storage_dns_records_hosts", id: false, force: :cascade do |t|
    t.bigint "storage_dns_record_id", null: false
    t.bigint "storage_host_id", null: false
    t.index ["storage_dns_record_id", "storage_host_id"], name: "dns_record_id_host_id_index"
    t.index ["storage_host_id", "storage_dns_record_id"], name: "host_id_dns_record_id_index"
  end

  create_table "storage_hosts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_storage_hosts_on_name", unique: true
  end

  add_foreign_key "storage_dns_records_hosts", "storage_dns_records"
  add_foreign_key "storage_dns_records_hosts", "storage_hosts"
end
