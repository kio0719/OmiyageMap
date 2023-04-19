FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.charcters(number:20) }
    post
    user { post.user }
  end
end
