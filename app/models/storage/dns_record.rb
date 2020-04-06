require 'resolv'

class Storage::DnsRecord < ApplicationRecord
  validates :ip, presence: true, format: { with: Resolv::AddressRegex }

  has_and_belongs_to_many :hosts, class_name: 'Storage::Host',
                                  foreign_key: 'storage_dns_record_id',
                                  association_foreign_key: 'storage_host_id'
end
