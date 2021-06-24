FactoryBot.define do
  factory :tweets_tag do
    title {Faker::Lorem.characters(number: 100)}
    text {Faker::Lorem.paragraph}
    prefecture_id { '1' }
    city_id { Faker::Number.between(from: 1, to:188) }
    name { 'one,two,three,four,five,six,seven,eight,nine,ten' }

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')   
    end  

  end
end
