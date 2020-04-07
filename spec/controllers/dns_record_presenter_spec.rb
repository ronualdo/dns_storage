require 'rails_helper'

RSpec.describe DnsRecordPresenter do
  describe '.present_multiple_records' do
    it 'presents an empty list of dns records' do
      expected_result = {
        total_records: 0,
        records: [],
        related_hostnames: []
      }

      result = described_class.present_multiple_records([])

      expect(result).to eq(expected_result)
    end

    it 'presents a list of dns records' do
      hosts = build_list(:host, 1, name: 'ipsum.com')
      dns_records = build_list(:dns_record, 2, id: 1, hosts: hosts)
      expected_result = {
        total_records: 2,
        records: [
          { id: 1, ip_address: '1.1.1.1' },
          { id: 1, ip_address: '1.1.1.1' }
        ],
        related_hostnames: [
          { hostname: hosts.first.name, count: 0 },
          { hostname: hosts.first.name, count: 0 }
        ]
      }

      result = described_class.present_multiple_records(dns_records)

      expect(result).to eq(expected_result)
    end
  end

  describe '.present_single_created_record' do
    it 'presents a "created" dns record' do
      expected_result = { id: 1 }
      dns_record = build(:dns_record, id: 1)

      result = described_class.present_single_created_record(dns_record)

      expect(result).to eq(expected_result)
    end
  end
end
