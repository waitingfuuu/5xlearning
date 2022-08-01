# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :restrict_with_exception

  has_secure_password
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :admin, presence: true

  before_destroy do
    if User.where(admin: 'admin').count <= 1
      errors.add(:base, I18n.t('flash.admin_can_not_be_empty'))
      throw :abort
    end
  end
end
