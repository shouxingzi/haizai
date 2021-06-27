FactoryBot.define do
  factory :tweet do
    title {Faker::Lorem.characters(number: 100)}
    text {Faker::Lorem.paragraph}
    prefecture_id { '1' }
    city_id { Faker::Number.between(from: 1, to:188) }

    association :user

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end  

  end
end
