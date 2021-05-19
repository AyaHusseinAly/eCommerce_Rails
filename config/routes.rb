Rails.application.routes.draw do
  devise_for :users
  get 'search', to:'home#searchInProduct'
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  get '/orders/:id', to:"orders#index"
  get '/orders',to: "orders#index"
  #get '/products/:id/:rating' => 'products#rate', as: :rate_product
  resources :users, only: [:show], param: :username, path: ""
  
  resources :categories
  resources :products do
    resources :rate_reviews
  end
  root 'home#index'
end
