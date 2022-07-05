Rails.application.routes.draw do
  get "/task", to: "pages#task"

  resources :tasks
end
