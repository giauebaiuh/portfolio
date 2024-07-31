FactoryBot.define do
  factory :post_comment do
    association :post_image
    user { post_image.user }
      body { Faker::Lorem.characters(number:10) }
  end
end