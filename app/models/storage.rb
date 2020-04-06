module Storage
  class << self
    def table_name_prefix
      'storage_'
    end

    def register_dns_record(ip, hostnames)
      DnsRecord.new(ip: ip).tap do |new_record|
        new_record.hosts << hostnames.map { |hostname| Host.find_or_create_by(name: hostname) }
        new_record.save
      end
    end
  end
end
