Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :users, only: [:show, :create]

  get '/register', to: 'users#new'

  resources :merchants, only: [:index]

  resources :users, only: [:new, :edit, :create]

  get '/profile', to: "users#show"
  get '/profile/edit', to: "users#edit"

  namespace :profile do
    resources :orders, only: [:index, :show]
  end

  put '/users', to: "users#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  #these gotta go in a resource
  get '/cart', to: 'carts#show'
  delete '/cart', to: 'carts#destroy'
  get '/checkout', to: 'carts#new'
  post '/checkout', to: 'carts#create'

  delete '/logout', to: "sessions#delete"

  get '/dashboard', to: "merchants#show"

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
end
