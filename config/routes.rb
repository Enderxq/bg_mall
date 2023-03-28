Rails.application.routes.draw do
  resources :addresses
  resources :shopping_car
  resources :orders
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show] do
    resources :kinds, only: [:index, :show]
  end

   root 'sessions#welcome'

   resources :users, only: [:new, :create]
   resources :sessions, only: [:new, :create]
   #get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'
   get 'welcome', to: 'sessions#welcome'
   get 'authorized', to: 'sessions#page_requires_login'
   get '/products/search', to: 'products#search'
   get '/profile/change_pwd', to: 'users#show'
   put '/profile/change_pwd', to: 'users#change_pwd'

  namespace :admin do
    root 'sessions#new'

    resources :sessions

    resources :users do
      resources :orders
      resources :addresses
      resources :shopping_car
    end

    resources :products
    resources :categories do
      resources :kinds
    end
    
  end
=begin
   get 'shopping_car', to: 'shopping_car#index'
   put 'shopping_car/update', to: 'shopping_car#update'
=end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
