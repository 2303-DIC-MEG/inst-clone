Rails.application.routes.draw do
  root to: 'pictures#new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :pictures
end
