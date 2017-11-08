Rails.application.routes.draw do
  resources :users
  resources :loans

  root 'rails#cool'

  get '/cool' => 'rails#cool'
  get '/sweet' => 'rails#sweet'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
