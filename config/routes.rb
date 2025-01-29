Rails.application.routes.draw do
  #get "/products", to: "products#index"
  #get "/products/:id", to: "products#show"

  #get "/products/new", to "products#new"
  #post "/products", to: "products#create"
  
  #get "/products/:id", to "products#edit"
  #put "/products/:id", to "products#update"
  #patch "/products/:id", to: "products#update"

  #delete "/products/:id", to: "products#destroy"

  # This is how tippically we'll written our routes. 
  # But typing out these routes every time is redundant, 
  # so Rails provides a shortcut for defining them. To create all of the same CRUD routes,
  # replace the above routes with this single line:

  resources :products
  root "products#index"
end
