FactoryBot.define do
  factory :post do
    title { "Test title" }
    howto { "Test howto" }
    num_of_people { "一人" }
    play_style { "もくもく" }
    association :user
  end
end