Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users
  get 'sessions/new'
  resources :sessions
end
