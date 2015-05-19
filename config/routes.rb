Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
  devise_for :users
  resources :users
  get '/users/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
