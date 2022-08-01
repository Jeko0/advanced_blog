FactoryBot.define do 
  factory :user do 
    email { "example@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
    role {1}
    id {1}
  end
end