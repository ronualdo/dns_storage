require 'rails_helper'

RSpec.describe Storage::DnsRecord, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:ip) }
    it { should_not allow_value('300.123.12.9').for(:ip) }
    it { should allow_values('127.0.2.12', '168.12.10.11').for(:ip) }
  end

  describe '#includes_all_hostnames?' do
    it 'returns true to an empty list of hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_all_hostnames?([])

      expect(result).to be_truthy
    end

    it 'returns true if dns record includes list of hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_all_hostnames?([dolor.name])

      expect(result).to be_truthy
    end

    it 'returns false if dns record does not include list of hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      lorem = build(:host, name: 'lorem.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_all_hostnames?([dolor.name, lorem.name])

      expect(result).to be_falsy
    end

    it 'returns false if dns record does not have any hosts' do
      lorem = build(:host, name: 'lorem.com')
      dns_record = build(:dns_record, hosts: [])

      result = dns_record.includes_all_hostnames?([lorem.name])

      expect(result).to be_falsy
    end
  end

  describe '#includes_any_hostnames?' do
    it 'returns true if dns records includes one of the hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_any_hostnames?([dolor.name])

      expect(result).to be_truthy
    end

    it 'returns true if dns records includes all hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_any_hostnames?([dolor.name, ipsum.name])

      expect(result).to be_truthy
    end

    it 'returns false if dns records does not include any of the hostnames' do
      ipsum = build(:host, name: 'ipsum.com')
      dolor = build(:host, name: 'dolor.com')
      amet = build(:host, name: 'amet.com')
      lorem = build(:host, name: 'lorem.com')
      dns_record = build(:dns_record, hosts: [ipsum, dolor])

      result = dns_record.includes_any_hostnames?([lorem.name, amet.name])

      expect(result).to be_falsy
    end
  end
end
