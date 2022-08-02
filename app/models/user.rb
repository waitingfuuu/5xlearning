# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :role, presence: true

  enum role: { admin: 'admin', general: 'general' }

  before_destroy :check_last_admin

  private

  def check_last_admin
    return unless admin? && the_last_admin?

    errors.add(:base, I18n.t('flash.admin_can_not_be_empty'))
    throw :abort
  end

  def the_last_admin?
    User.where(role: 'admin').count <= 1
  end

  def admin?
    role == 'admin'
  end
end
