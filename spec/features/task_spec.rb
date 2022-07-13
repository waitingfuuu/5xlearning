# frozen_string_literal: true

require 'rails_helper'

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

  context 'when tasks order by created_at' do
    let(:tasks) { create_list(:task, 3) }

    it 'first task is newest' do
      str = find('tr#0').find('.created_at').text
      view_created_at = DateTime.parse(str).strftime('%Y-%m-%d %H:%M:%S +%H%M')
      db_created_at = tasks[0].created_at.strftime('%Y-%m-%d %H:%M:%S +%H%M')
      expect(db_created_at).to eq(view_created_at)
    end
  end
end
