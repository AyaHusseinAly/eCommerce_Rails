Rails.application.routes.draw do
  
  devise_for :users
  get 'search', to:'home#searchInProduct'
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  get '/orders/:id', to:"orders#index"
  get '/orders',to: "orders#index"
  #get '/products/:id/:rating' => 'products#rate', as: :rate_product
  # resources :users, only: [:show], param: :username, path: ""
  ################################add to cart , wishing list  routes ###############################
  resources :wishing_list_items
  get 'addToWishingList/:id', to: 'wishing_list_items#addToWishingList', as: 'addToWishingList'
  get 'destroyToWishingList/:id', to: 'wishing_list_items#destroy', as: 'destroy_wishinglistitem'
  get 'addToCart/index', to: 'shopping_card_items#index', as: 'shopping_card_item_index'
  get 'addToCart/:id', to: 'shopping_card_items#addToCart', as: 'addToCart'
  get 'addToCartFromWishingList/:id', to: 'shopping_card_items#addToCartFromWishingList', as: 'addToCartFromWishingList'
  patch 'changeQuantity', to: 'shopping_card_items#changeQuantity', as: 'changeQuantity'
  get 'checkout', to: 'shopping_card_items#checkout', as: 'checkout'
  patch 'cancleShoppingCard',to:'shopping_card_items#cancleShoppingCartItem',as:'cancleShoppingCartItem'



  resources :categories

  root to: 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products do
    resources :rate_reviews
  end
 
  
end
