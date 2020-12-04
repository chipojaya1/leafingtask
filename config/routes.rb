Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions
  namespace :admin do
    resources :users
  end
end
