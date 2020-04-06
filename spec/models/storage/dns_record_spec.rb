require 'rails_helper'

RSpec.describe Storage::DnsRecord, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:ip) }
    it { should_not allow_value('300.123.12.9').for(:ip) }
    it { should allow_values('127.0.2.12', '168.12.10.11').for(:ip) }
  end
end
