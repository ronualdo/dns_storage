class DnsRecordsController < ApplicationController
  def create
    dns_record = Storage.register_dns_record(ip, hostnames)

    if dns_record.valid?
      render json: DnsRecordPresenter.present_single_created_record(dns_record),
             status: :created
    else
      render json: { "error" => dns_record.errors.messages }, status: 500
    end
  end

  def index
    if page
      dns_records = Storage.retrieve_dns_records(
        page: page,
        included_hostnames: included_hostnames,
        excluded_hostnames: excluded_hostnames
      )

      render json: DnsRecordPresenter.present_multiple_records(dns_records), status: :ok
    else
      render json: { "error" => "page parameter is mandatory" }, status: 500
    end
  end

  private

  def dns_record_params
    params.require(:dns_records)
          .permit(:ip, hostnames_attributes: [:hostname])
  end

  def ip
    dns_record_params.fetch(:ip)
  end

  def hostnames
    dns_record_params.fetch(:hostnames_attributes, {}).map do |host_attrs|
      host_attrs.fetch(:hostname)
    end
  end

  def page
    params[:page]&.to_i
  end

  def included_hostnames
    params[:included_hostnames]
  end

  def excluded_hostnames
    params[:excluded_hostnames]
  end
end
