Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :users, only: [:show, :create]

  get '/register', to: 'users#new'

  resources :merchants, only: [:index]

  get '/login', to: 'sessions#new'
end
