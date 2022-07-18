# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  # enum :priority, [I18n.t('task.high'), I18n.t('task.medium'), I18n.t('task.low')]
  # enum :state, [I18n.t('task.pending'), I18n.t('task.processing'), I18n.t('task.solved')]
  enum priority: { high: 0, medium: 1, low: 2 }
  enum state: { pending: 0, processing: 1, solved: 2 }
end
