Rails.application.routes.draw do
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  resources :categories
  root 'home#index'
end
