FactoryBot.define do
  factory :host, class: 'Storage::Host' do
    name { 'ipsum.com' }
  end
end
