# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'admin', to: 'admin#index'
  get '/admin/user_tasks/:id', to: 'admin#user_tasks', as: 'user_tasks'

  resources :tasks
  resources :users
  resources :sessions
  resources :admin
end
