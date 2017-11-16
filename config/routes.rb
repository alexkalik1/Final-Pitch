Rails.application.routes.draw do
  root 'sessions#new'

  resources :sessions
  resources :users
  resources :loans
  get '/loans/:id/repay' => 'loans#repay', :as => :repay_loans
  get '/users/:id' => 'users#show', :as => :profile

  # get '/cool' => 'rails#cool'
  # get '/sweet' => 'rails#sweet'
  #
  # get '/signup' => 'users#new'
  # post '/users' => 'users#create'
  #
  # post '/login' => 'sessions#create'
  # get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
