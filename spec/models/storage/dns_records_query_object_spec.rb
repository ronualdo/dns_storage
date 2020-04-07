require 'rails_helper'

RSpec.describe Storage::DnsRecordsQueryObject, type: :model do
  describe '#data' do
    it 'returns an empty collection when there is no dns records' do
      query_object = described_class.new

      dns_records = query_object.data

      expect(dns_records).to be_empty
    end

    context 'given there are dns records' do
      let(:ipsom) { create(:host, name: 'ipsom.com') }
      let(:lorem) { create(:host, name: 'lorem.com') }
      let(:dolor) { create(:host, name: 'dolor.com') }
      let!(:first_record) { create(:dns_record, ip: '1.1.1.1', hosts: [ipsom, lorem, dolor]) }
      let!(:second_record) { create(:dns_record, ip: '2.2.2.2', hosts: [ipsom]) }

      it 'returns all dns records' do
        query_object = described_class.new

        dns_records = query_object.data

        expect(dns_records).to match([first_record, second_record])
      end

      it 'returns all records when included hostname exists' do
        query_object = described_class.new
        hostnames = [ipsom.name]

        dns_records = query_object
          .include_hostnames(hostnames)
          .data

        expect(dns_records).to match([first_record, second_record])
      end

      it 'returns only second record when there is an excluded hostname' do
        query_object = described_class.new
        included_hostnames = [ipsom.name]
        excluded_hostnames = [lorem.name]

        dns_records = query_object
          .include_hostnames(included_hostnames)
          .exclude_hostnames(excluded_hostnames)
          .data

        expect(dns_records).to match([second_record])
      end
    end
  end
end
