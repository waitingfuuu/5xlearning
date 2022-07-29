# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    admin { 'admin' }
    password_digest { BCrypt::Password.create('password') }
  end
end
