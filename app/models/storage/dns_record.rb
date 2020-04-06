class Storage::DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hosts, class_name: 'Storage::Host',
                                  foreign_key: 'storage_dns_record_id',
                                  assoaciation_foreign_key: 'storage_host_id'
end
