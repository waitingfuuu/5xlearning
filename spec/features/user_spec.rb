# frozen_string_literal: true

require 'rails_helper'

describe 'users', type: :feature do
  before { visit root_path }

  let(:user) { create(:user) }

  it 'when user sign up' do
    click_link I18n.t('user.signup')
    fill_in 'user[name]', with: 'user'
    fill_in 'user[password]', with: '123'
    click_button I18n.t('user.signup')
    expect(page).to have_content('user')
  end

  it 'when user login' do
    click_link I18n.t('user.login')
    fill_in 'session[name]', with: user.name
    fill_in 'session[password]', with: user.authenticate(user.password_digest)
    click_button I18n.t('user.login')
    binding.breakc
    expect(page).to have_content(user.name)
  end
end
