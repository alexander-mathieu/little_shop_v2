Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :users, only: [:show, :create]

  get '/register', to: 'users#new'

  resources :merchants, only: [:index]

  resources :users, only: [:new, :edit, :create]

  get '/profile', to: "users#show"
  get '/profile/edit', to: "users#edit"
  put '/users', to: "users#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  post '/cart', to: 'carts#create'
  get '/cart', to: 'carts#show'
  delete '/logout', to: "sessions#delete"

  get '/dashboard', to: "merchants#show"
  
  get 'admin/dashboard', to: 'dashboard#index'
end
