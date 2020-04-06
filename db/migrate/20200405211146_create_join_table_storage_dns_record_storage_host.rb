class CreateJoinTableStorageDnsRecordStorageHost < ActiveRecord::Migration[6.0]
  def change
    create_join_table :storage_dns_records, :storage_hosts do |t|
      t.index [:storage_dns_record_id, :storage_host_id], name: 'dns_record_id_host_id_index'
      t.index [:storage_host_id, :storage_dns_record_id], name: 'host_id_dns_record_id_index'
    end

    add_foreign_key :storage_dns_records_hosts, :storage_dns_records
    add_foreign_key :storage_dns_records_hosts, :storage_hosts
  end
end
