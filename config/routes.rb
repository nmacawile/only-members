Rails.application.routes.draw do
  
  root "posts#index"
  get "/signin" => "sessions#new"
  post "/signin" => "sessions#create"
  delete "/signout" => "sessions#destroy"
  resources :users, except: [:new, :create]
  get "/signup" => "users#new"
  post "/signup" => "users#create"
  resources :posts, only: [:create, :destroy]
end
