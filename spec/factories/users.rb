FactoryBot.define do
  factory :user do
    name { 'ユーザーA' }
    email { 'a@example.com' }
    password { 'password!' }
  end
end
