FactoryBot.define do
  factory :room_message do
    content {Faker::Lorem.paragraph}
    current_user_id { 1 }
    tweet_user_id { 2 }
    tweet_id { 1 }
    room_name { 'test' }
  end
end
