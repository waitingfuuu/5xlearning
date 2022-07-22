# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_tasks, dependent: :restrict_with_exception
  has_many :tasks, through: :user_tasks
end
