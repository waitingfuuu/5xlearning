# frozen_string_literal: true

FactoryBot.define do
  factory :user_task do
    user_id { 1 }
    task_id { 1 }
  end
end
