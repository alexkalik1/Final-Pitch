Rails.application.routes.draw do
  root 'sessions#splashpage'
  # root 'sessions#new' #TODO work on this one!

  resources :sessions
  resources :users
  resources :loans

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
  get '/profilepage' => 'sessions#profilepage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
