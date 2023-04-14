Rails.application.routes.draw do
  root to: 'pictures#new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  resources :pictures do
    collection do
      post :confirm
      get :bookmarks
    end
  end
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  resources :pictures, expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end
end
