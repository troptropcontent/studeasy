FactoryBot.define do
  factory :user do
    email { "testuser@example.com" }
    password { "test123" }
    confirmed_password { "test123" }
  end
end
