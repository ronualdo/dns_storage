module Storage
  class << self
    def table_name_prefix
      'storage_'
    end

    def register_dns_record(params)
      DnsRecord.new(ip: params[:ip]).tap do |new_record|
        new_record.hosts << params[:hostnames_attributes].map do |host|
          Host.find_or_create_by(name: host[:hostname])
        end

        new_record.save
      end
    end
  end
end
