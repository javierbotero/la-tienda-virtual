Rails.application.routes.draw do
  get 'producs/index'
  get 'producs/show'
  get '/login' => 'authorization#login', as: 'login'
  get '/logout'=> 'authorization#logout', as: 'logout'
  get '/register'=> 'authorization#register', as: 'register'
  post '/login_user'=> 'authorization#login_user', as: 'login_user'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  resources :users do
    resources :orders
    resources :billings
    resources :shipping_addressess
  end

  resources :authorizations, only: [:create, :destroy]

  resources :products, only: [:index, :show]
end
