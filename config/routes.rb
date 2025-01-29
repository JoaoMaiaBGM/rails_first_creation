Rails.application.routes.draw do
  get "user/new"
  get "user/create"
  resource :session
  resources :users, only: [:new, :create]
  resources :passwords, param: :token
  resources :products

  root "products#index"
end
