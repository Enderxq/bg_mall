Rails.application.routes.draw do
  resources :products
  resources :categories
   root 'application#index'

   resources :users, only: [:new, :create]
   resources :sessions, only: [:new, :create]
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
   get 'authorized', to: 'sessions#page_requires_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
