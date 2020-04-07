require 'rails_helper'

RSpec.describe Storage do
  describe '.register_dns_record' do
    it 'retusn a new dns record and its new hostnames' do
      ip = '192.168.2.2'
      hostnames = ['ipsum.com']

      dns_record = described_class.register_dns_record(ip, hostnames)
      
      expect(dns_record.valid?).to be_truthy
      expect(dns_record.id).not_to be_nil
      expect(dns_record.ip).to eq('192.168.2.2')
      expect(dns_record.hosts.size).to eq(1)
      expect(dns_record.hosts.pluck(:name)).to match(['ipsum.com'])
    end

    it 'persists new dns record' do
      ip = '192.168.2.2'
      hostnames = ['ipsum.com']

      expect {
        described_class.register_dns_record(ip, hostnames)
      }.to change { Storage::DnsRecord.count }.by(1)
    end

    it 'persists new host' do
      ip = '192.168.2.2'
      hostnames = ['ipsum.com']

      expect {
        described_class.register_dns_record(ip, hostnames)
      }.to change { Storage::Host.count }.by(1)
    end

    context 'given that one host already exists' do
      let(:host) { create(:host) }

      it 'does not persist a new host' do
        ip = '192.168.2.2'
        hostnames = ['ipsum.com']

        expect {
          described_class.register_dns_record(ip, hostnames)
        }.to change { Storage::Host.count }.by(1)
      end
    end
  end

  describe '.retrieve_dns_records' do
    context 'given there are dns records registered' do
      let(:ipsom) { create(:host, name: 'ipsom.com') }
      let(:lorem) { create(:host, name: 'lorem.com') }
      let(:dolor) { create(:host, name: 'dolor.com') }
      let!(:first_record) { create(:dns_record, ip: '1.1.1.1', hosts: [ipsom, lorem]) }
      let!(:second_record) { create(:dns_record, ip: '2.2.2.2', hosts: [dolor]) }

      it 'it returns all dns records if no filters are provided' do
        dns_records = described_class.retrieve_dns_records(page: 1)

        expect(dns_records).to match([first_record, second_record])
      end

      it 'paginates results' do
        dns_records = described_class.retrieve_dns_records(page: 2)

        expect(dns_records).to be_empty
      end
    end
  end
end
