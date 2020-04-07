module DnsRecordPresenter
  class << self
    def present_single_created_record(dns_record)
      { id: dns_record.id }
    end

    def present_multiple_records(dns_records)
      {
        total_records: dns_records.size,
        records: dns_records.map { |record| present_single_record(record) },
        related_hostnames: dns_records.flat_map { |record| present_multiple_hosts(record.hosts) }
      }
    end

    private

    def present_single_record(dns_record)
      { id: dns_record.id, ip_address: dns_record.ip }
    end

    def present_multiple_hosts(hosts)
      hosts.map { |host| { hostname: host.name, count: host.dns_records.count } }
    end
  end
end
