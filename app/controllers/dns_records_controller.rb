class DnsRecordsController < ApplicationController
  def create
    render json: {id: 1}, status: :created
  end
end