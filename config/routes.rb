# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'admin', to: 'admin/users#index'
  get '/admin/user/tasks/:id', to: 'admin/users#tasks', as: 'tasks'

  resources :tasks
  resources :users
  resources :sessions

  namespace :admin do
    resources :users
  end
end
