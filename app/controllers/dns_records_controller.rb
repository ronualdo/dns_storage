class DnsRecordsController < ApplicationController
  def create
    dns_record = Storage.register_dns_record(dns_record_params)
    if dns_record.valid?
      render json: dns_record, status: :created
    else
      render json: { "error" => "error" }, status: :error
    end
  end

  private

  def dns_record_params
    params.require(:dns_records)
          .permit(:ip, hostnames_attributes: [:hostname])
  end
end
