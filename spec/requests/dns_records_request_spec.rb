require 'rails_helper'

RSpec.describe "DnsRecords API", type: :request do
  let(:json_header) do
    { 'CONTENT_TYPE' => 'application/json' }
  end

  it 'allows to create dns records and its hostnames' do
    dns_record_params = <<-PARAMS
      {
        "dns_records": {
         "hostnames_attributes": [
          {"hostname": "lorem.com"}
         ] 
        }
      }
    PARAMS

    post '/dns_records', params: dns_record_params, headers: json_header

    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)['id']).not_to be_nil
  end
end
