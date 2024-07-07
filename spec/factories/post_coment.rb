FactoryBot.define do
  factory :post_comment do
    association :post_image
    user { post_image.user }
      body { Faker::Lorem.characters(nunber:10) }
  end
end