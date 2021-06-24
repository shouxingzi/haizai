FactoryBot.define do
  factory :message do
    content {Faker::Lorem.paragraph}
    association :user
    association :room
  end
end
