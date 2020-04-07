class Storage::DnsRecordsQueryObject
  def initialize(relation = ::Storage::DnsRecord.all)
    @relation = relation.lazy
    @included_hostnames = []
    @excluded_hostnames = []
  end

  def data
    @relation.filter { |record| record.includes_all_hostnames?(@included_hostnames) }
             .reject { |record| record.includes_any_hostnames?(@excluded_hostnames) }
             .to_a
  end

  def include_hostnames(hostnames)
    @included_hostnames = hostnames if hostnames

    self
  end

  def exclude_hostnames(hostnames)
    @excluded_hostnames = hostnames if hostnames

    self
  end
end
