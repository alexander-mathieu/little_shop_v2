Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:new, :show, :edit]

  get '/profile', to: "users#show"

  get '/login', to: 'sessions#new'
end
