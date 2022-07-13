# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :task do
    user_id { Faker::Number.decimal_part(digits: 2) }
    title { Faker::Job.title }
    content { Faker::String.random }
    tag { Faker::String.random(length: 4) }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1, format: :default) }
    priority { '1' }
    state { '0' }
  end
end

describe 'tasks', type: :feature do
  before do
    create(:task, title: 'test-task')
    visit root_path
  end

  context 'when create task' do
    it 'link to new task path' do
      click_link I18n.t('form.create_task')
      expect(page).to have_content(I18n.t('form.create_task'))
    end

    it 'shows new task' do
      visit new_task_path
      within('#task_form') do
        fill_in 'task[title]', with: 'newtask'
      end
      click_button I18n.t('form.submitBtn')
      expect(page).to have_content('newtask')
    end
  end

  context 'when edit task' do
    it 'has test-task' do
      expect(page).to have_content('test-task')
    end

    it 'shows edited task' do
      click_link I18n.t('index.edit')
      within('#task_form') do
        fill_in 'task[title]', with: 'change-title'
      end
      click_button I18n.t('form.submitBtn')
      expect(page).to have_content('change-title')
    end
  end

  context 'when delete task' do
    it 'has a task' do
      expect(Task.count).to eq(1)
    end

    it 'deleted the task' do
      click_link I18n.t('index.delete')
      expect(Task.count).to eq(0)
    end
  end
end
