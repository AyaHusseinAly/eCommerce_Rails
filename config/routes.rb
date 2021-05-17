Rails.application.routes.draw do
  devise_for :users
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  get '/products/:id/:rating' => 'products#rate', as: :rate_product

  resources :categories
  resources :products do
    resources :rate_reviews
  end
  root 'home#index'
end
