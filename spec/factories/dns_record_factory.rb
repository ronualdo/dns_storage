FactoryBot.define do
  factory :dns_record, class: 'Storage::DnsRecord' do
    ip { '1.1.1.1' }
  end
end
