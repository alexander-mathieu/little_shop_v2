Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:new, :edit, :create]

  get '/profile', to: "users#show"
  get '/profile/edit', to: "users#edit"
  put '/users', to: "users#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/cart', to: 'carts#show'
  delete '/logout', to: "sessions#delete"
end
