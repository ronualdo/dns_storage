class CreateStorageDnsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :storage_dns_records do |t|
      t.string :ip, nullable: false

      t.timestamps
    end
  end
end
