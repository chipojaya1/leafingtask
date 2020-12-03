Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users
  get 'sessions/new'
  resources :sessions
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/show'
    get 'users/index'
  end
end
