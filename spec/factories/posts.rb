FactoryBot.define do
  factory :post do
    title { "Test title" }
    howto { "Test howto" }
    num_of_people { "Test num_of_people" }
    play_style { "Test play_style" }
    association :user
  end
end
