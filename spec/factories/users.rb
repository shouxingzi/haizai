FactoryBot.define do
  factory :user do
    username{'test'}
    email{'test@example'}
    password{'test00'}
    password_confirmation {password}    
  end
end
