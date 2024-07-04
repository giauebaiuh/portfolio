FactoryBot.define do
  factory :post_image do
    association :user
      image { { io: File.open('app/assets/images/no_image.jpg'), filename: 'no_image.jpg' } }
      trade_name { Faker::Lorem.characters(number: 5) }
      caption { Faker::Lorem.characters(number: 10) }
      prefecture { '北海道' }
      genre { '和菓子' }
      star { 3 }
  end
end