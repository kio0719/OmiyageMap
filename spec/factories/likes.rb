FactoryBot.define do
  factory :like do
    post
    user { post.user }
  end
end
