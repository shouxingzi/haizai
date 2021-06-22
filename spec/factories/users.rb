FactoryBot.define do
  factory :user do
    username{'abcdefghijklmno'}
    email{'test@example'}
    password{'test00'}
    password_confirmation {password}    
  end
end
