FactoryBot.define do
  factory :tweet_tag_relation do
    association :tweet
    association :tag
  end
end
