Rails.application.routes.draw do
  root 'users#new'
  resources :tasks
  resources :sessions
  resources :users, only:[:new, :create, :show]
  namespace :admin do
    resources :users, only:[:index, :edit, :update, :new, :create, :show, :destroy]
  end
end
