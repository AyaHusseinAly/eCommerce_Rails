Rails.application.routes.draw do
  devise_for :users
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"

  root 'home#index'
end
