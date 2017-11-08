Rails.application.routes.draw do
  root 'sessions#new'

  resource :sessions
  resources :users
  resources :loans

  get '/cool' => 'rails#cool'
  get '/sweet' => 'rails#sweet'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
