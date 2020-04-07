module Storage
  class << self
    PAGE_LIMIT = 10

    def table_name_prefix
      'storage_'
    end

    def register_dns_record(ip, hostnames)
      DnsRecord.new(ip: ip).tap do |new_record|
        new_record.hosts << hostnames.map { |hostname| Host.find_or_create_by(name: hostname) }
        new_record.save
      end
    end

    def retrieve_dns_records(page:, included_hostnames: [], excluded_hostnames: [])
      relation = DnsRecord.limit(PAGE_LIMIT)
                          .offset(calculate_offset(page))

      DnsRecordsQueryObject.new(relation)
                           .include_hostnames(included_hostnames)
                           .exclude_hostnames(excluded_hostnames)
                           .data
    end

    private

    def calculate_offset(page)
      return 0 unless page
      (page - 1) * PAGE_LIMIT
    end
  end
end
