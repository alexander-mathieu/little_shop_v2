Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index]
end
