Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show, :edit, :destroy, :new, :create]
  post '/items/:id', to: "items#update"
  post '/items/enable/:id', to: "items#enable"
  post '/items/disable/:id', to: "items#disable"

  resources :users, only: [:show, :create]
  resources :users, only: [:new, :edit, :create]
  get '/register', to: 'users#new'

  resources :merchants, only: [:index] do
  end

  resources :users, only: [:new, :edit, :create]

  get '/profile', to: "users#show"
  get '/profile/edit', to: "users#edit"

  namespace :profile do
    resources :orders, only: [:index, :show, :destroy]
  end

  put '/users', to: "users#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  #these gotta go in a resource
  get '/cart', to: 'carts#show'
  post '/cart', to: 'carts#create'
  delete '/cart', to: 'carts#destroy'
  post '/checkout', to: 'profile/orders#create'

  delete '/logout', to: "sessions#delete"

  get '/dashboard', to: "merchants#show"
  get '/dashboard/orders/:id', to: 'merchants/orders#show'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    get '/users/:user_id/orders', to: 'orders#index', as: :user_orders
    patch '/users/upgrade/:user_id', to: 'users#upgrade', as: :user_upgrade

    resources :merchants, only: [:show, :update]
    post '/merchants/enable/:id', to: 'merchants#enable'
    post '/merchants/disable/:id', to: 'merchants#disable'
    resources :users, only: [:index, :show]
  end
end
