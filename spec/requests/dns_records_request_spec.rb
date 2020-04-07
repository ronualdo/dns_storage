require 'rails_helper'

RSpec.describe "DnsRecords API", type: :request do
  let(:json_header) do
    { 'CONTENT_TYPE' => 'application/json' }
  end

  it 'allows to create dns records and its hostnames' do
    dns_record_params = <<-PARAMS
      {
        "dns_records": {
          "ip": "192.168.0.12",
          "hostnames_attributes": [
            {"hostname": "lorem.com"}
          ] 
        }
      }
    PARAMS

    post '/dns_records', params: dns_record_params, headers: json_header

    expect(response).to have_http_status(:created)
    json_response = JSON.parse(response.body)
    expect(json_response['id']).not_to be_nil

    get '/dns_records'

    expect(response).to have_http_status(:ok)
    json_response = JSON.parse(response.body)
    expect(json_response['total_records']).to eq(1)
    expect(json_response['records']).not_to be_nil
    # expect(json_response['records']['id']).not_to be_nil
    # expect(json_response['records']['ip_address']).to eq('192.168.0.12') expect(json_response['related_hostnames']).not_to be_nil
    expect(json_response['related_hostnames']).to match([{'hostname' => 'lorem.com', 'count' => 1}])
  end

  it 'returns errors when parameters are invalid' do
    dns_record_params = <<-PARAMS
      {
        "dns_records": {
          "ip": "300.168.0.12",
          "hostnames_attributes": [
            {"hostname": "lorem.com"}
          ] 
        }
      }
    PARAMS

    post '/dns_records', params: dns_record_params, headers: json_header

    expect(response).to have_http_status(500)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq({"ip"=>["is invalid"]})
  end
end
