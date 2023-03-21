Rails.application.routes.draw do
  get 'producs/index'
  get 'producs/show'
  get '/login' => 'authorization#login', as: 'login'
  get '/register'=> 'authorization#register', as: 'register'
  post '/users/create' => 'authorization#create', as: 'create_user'
  post '/login_user'=> 'authorization#login_user', as: 'login_user'
  delete '/logout' => 'authorization#logout', as: 'logout'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  resources :users do
    resources :orders
    resources :billings
    resources :shipping_addressess
  end

  resources :products, only: [:index, :show]
end
