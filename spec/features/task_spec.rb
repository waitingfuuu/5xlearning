# frozen_string_literal: true

require 'rails_helper'

describe 'tasks', type: :feature do
  let!(:task) { create(:task, :with_user, title: 'title') }

  before do
    visit root_path
    click_link I18n.t('user.login')
    fill_in 'session[name]', with: User.first.name
    fill_in 'session[password]', with: 'password'
    click_button I18n.t('user.login')
  end

  context 'when create task' do
    it 'shows new task' do
      click_link I18n.t('form.create_task')
      within('#task_form') do
        fill_in 'task[title]', with: 'newtask'
      end
      click_button I18n.t('form.submitBtn')
      Task.where(title: 'newtask').first.user = User.first
      expect(page).to have_content('newtask')
    end
  end

  context 'when edit task' do
    it 'has task to edit' do
      expect(page).to have_content(task.title)
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
    let!(:tasks) { create_list(:task, 3, user: User.first) }

    it 'first task is newest' do
      str = find('tr#0').find('.created_at').text
      view_created_at = DateTime.parse(str).strftime('%Y/%m/%d %H:%M')
      db_created_at = tasks[0].created_at.strftime('%Y/%m/%d %H:%M')
      expect(db_created_at).to eq(view_created_at)
    end
  end

  context 'when tasks order by end_time' do
    before { create_list(:task, 3, user: User.first) }

    it 'using desc' do
      visit root_path(end_time: 'desc')

      end_time0 = DateTime.parse(find('tr#0').find('.end_time').text)
      end_time1 = DateTime.parse(find('tr#1').find('.end_time').text)

      expect(end_time0 > end_time1).to be true
    end

    it 'using asc' do
      visit root_path(end_time: 'asc')

      end_time0 = DateTime.parse(find('tr#0').find('.end_time').text)
      end_time1 = DateTime.parse(find('tr#1').find('.end_time').text)

      expect(end_time0 < end_time1).to be true
    end
  end

  context 'when search tasks' do
    before { create_list(:task, 10, user: User.first) }

    it 'find tasks by title' do
      fill_in 'search', with: task.title
      click_button I18n.t('index.searchBtn')
      title = find('tr#0').find('.title').text
      expect(title).to eq(task.title)
    end
  end

  context 'when tasks order by priority' do
    before do
      create(:task, priority: 0, user: User.first)
      create(:task, priority: 2, user: User.first)
    end

    it 'using desc' do
      visit root_path(priority: 'desc')

      priority = find('tr#0').find('.priority').text

      expect(priority).to eq(I18n.t('task.low'))
    end

    it 'using asc' do
      visit root_path(priority: 'asc')

      priority = find('tr#0').find('.priority').text

      expect(priority).to eq(I18n.t('task.high'))
    end
  end

  context 'when tasks order by state' do
    before do
      create(:task, state: 0, user: User.first)
      create(:task, state: 2, user: User.first)
    end

    it 'using desc' do
      visit root_path(state: 'desc')

      state = find('tr#0').find('.state').text

      expect(state).to eq(I18n.t('task.solved'))
    end

    it 'using asc' do
      visit root_path(state: 'asc')

      state = find('tr#0').find('.state').text

      expect(state).to eq(I18n.t('task.pending'))
    end
  end
end
