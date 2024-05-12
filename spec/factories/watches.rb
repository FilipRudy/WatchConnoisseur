# spec/factories/watches.rb
FactoryBot.define do
  factory :watch do
    name { Faker::Lorem.words(number: 2).join(' ') }
    description { Faker::Lorem.paragraph }
    category { Watch.categories.keys.sample }
    price { Faker::Number.between(from: 50, to: 500) }
    photo_url { Faker::Internet.url }
    association :user
  end
end
