# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user_id { Faker::Number.decimal_part(digits: 2) }
    title { Faker::Lorem.words }
    content { Faker::Lorem.paragraphs }
    tag { Faker::Lorem.words }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1, format: :default) }
    priority { '1' }
    state { '0' }
  end
end
