class Storage::Host < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :dns_records, class_name: 'Storage::DnsRecord',
                                        foreign_key: 'storage_host_id',
                                        association_foreign_key: 'storage_dns_record_id'
end
