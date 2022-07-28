# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  resources :tasks
  resources :users
  resources :sessions
end
