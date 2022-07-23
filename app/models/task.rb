# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  enum priority: { high: 0, medium: 1, low: 2 }
  enum state: { pending: 0, processing: 1, solved: 2 }
end
