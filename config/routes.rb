Rails.application.routes.draw do
  root "users#index"
  get "/signin" => "sessions#new"
  post "/signin" => "sessions#create"
  delete "/signout" => "sessions#destroy"
  resources :users
end
