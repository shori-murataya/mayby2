FactoryBot.define do
  factory :comment do
    content { "こんにちは" }
    association :user
    association :post
  end
end
