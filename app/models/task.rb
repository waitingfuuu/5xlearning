# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, :content, :tag, :start_time, :end_time, :priority, :state, presence: true
  validates :priority, inclusion: { in: %w[0 1 2] }
  validates :state, inclusion: { in: %w[0 1 2] }
end
