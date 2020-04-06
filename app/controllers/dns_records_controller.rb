class DnsRecordsController < ApplicationController
  def create
    dns_record = Storage.register_dns_record(ip, hostnames)

    if dns_record.valid?
      render json: dns_record, status: :created
    else
      render json: { "error" => "error" }, status: :error
    end
  end

  private

  def ip
    dns_record_params.fetch(:ip)
  end

  def hostnames
    dns_record_params.fetch(:hostnames_attributes, []).map do |host_attrs|
      host_attrs.fetch(:hostname)
    end
  end

  def dns_record_params
    params.require(:dns_records)
          .permit(:ip, hostnames_attributes: [:hostname])
  end
end
