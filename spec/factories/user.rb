FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:5) }
    user_comment { Faker::Lorem.characters(number:20) }
    email { Faker::Internet.email }
    password { 'abcdef' }
    password_confirmation { 'abcdef' }
  end
end