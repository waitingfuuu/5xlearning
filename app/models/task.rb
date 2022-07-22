# frozen_string_literal: true

class Task < ApplicationRecord
  has_many :user_tasks, dependent: :restrict_with_exception
  has_many :users, through: :user_tasks

  validates :title, presence: true
  enum priority: { high: 0, medium: 1, low: 2 }
  enum state: { pending: 0, processing: 1, solved: 2 }
end
