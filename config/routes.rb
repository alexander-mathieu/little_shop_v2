Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show, :edit, :destroy]
  post '/items/:id', to: "items#update"
  post '/items/enable/:id', to: "items#enable"
  post '/items/disable/:id', to: "items#disable"

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
  post '/cart', to: 'carts#create'
  delete '/cart', to: 'carts#destroy'

  delete '/logout', to: "sessions#delete"

  get '/dashboard', to: "merchants#show"

  namespace :admin do

    get '/dashboard', to: 'dashboard#index'
    resources :merchants, only: [:show, :update]
    # get '/dashboard/:id', to: 'merchants#show' I deleted this, It didnt break anything -Patrick neededfor ^^^
    get '/users/:user_id/orders', to: 'orders#index', as: :user_orders

    resources :users, only: [:index, :show]
  end
end
