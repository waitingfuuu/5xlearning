# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :restrict_with_exception
  validates :name, presence: true
  validates :password, presence: true
end
