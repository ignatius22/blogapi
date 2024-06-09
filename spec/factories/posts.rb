require 'faker'

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { false }
    img { Faker::Internet.url(host: 'example.com', path: '/image.jpg') } # Generates a random URL for a placeholder image

    user
  end
end
