# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    tag { Faker::Lorem.words }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1) }
    priority { Faker::Number.between(from: 0, to: 2) }
    state { Faker::Number.between(from: 0, to: 2) }
    association :user, factory: :user
  end
end
