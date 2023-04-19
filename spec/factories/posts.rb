FactoryBot.define do
  factory :post do
    name { Faker::Name.name }
    caption { Faker::Lorem.characters(number:20) }
    address { Faker::Address.city }
    user
  end
end
