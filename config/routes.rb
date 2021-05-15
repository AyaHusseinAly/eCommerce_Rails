Rails.application.routes.draw do
  devise_for :users
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  resources :categories
  resources :products
  root 'home#index'
end
