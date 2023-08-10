FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    association :topic
    # Add any other attributes you have in your Post model
  end
end