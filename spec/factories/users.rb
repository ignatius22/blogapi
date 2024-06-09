require 'faker'

FactoryBot.define do
  factory :user do
    fullname { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { BCrypt::Password.create('g00d_pa$$') }
  end
end
