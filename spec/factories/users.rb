FactoryBot.define do
  factory :user do
    name { "Taro" }
    sequence(:email) { |n| "taro#{n}@example.com" }
    password { "tarotaro" }
  end
end
