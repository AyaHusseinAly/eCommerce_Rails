Rails.application.routes.draw do
  
  devise_for :users
  get 'search', to:'home#searchInProduct'
  get 'api/products', to: "api#index"
  get 'api/products/:id', to: "api#show"
  get 'profile/:id', to: "profile#show"

  get 'seller/products/:id', to: "products#seller"
  get 'seller/orders/:id', to: "orders#seller"


  get '/orders',to: "orders#index"
  get '/orders/:id', to:"orders#index"
  
  #get '/products/:id/:rating' => 'products#rate', as: :rate_product

  

  # resources :users, only: [:show], param: :username, path: ""
  ################################add to cart , wishing list  routes ###############################
  resources :wishing_list_items
  # get 'addToWishingList/:id', to: 'wishing_list_items#addToWishingList', as: 'addToWishingList'
  get 'destroyToWishingList/:id', to: 'wishing_list_items#destroy', as: 'destroy_wishinglistitem'
  post 'addToWishingListForm', to: 'wishing_list_items#addToWishingListForm', as: 'addToWishingListForm'
  post 'destroyForm', to: 'wishing_list_items#destroyForm', as: 'destroyForm'
  
  get 'addToCart/index', to: 'shopping_card_items#index', as: 'shopping_card_item_index'
  post 'addToCartForm', to: 'shopping_card_items#addToCartForm', as: 'addToCartForm'
  # get 'addToCart/:id', to: 'shopping_card_items#addToCart', as: 'addToCart'
  get 'addToCartFromWishingList/:id', to: 'shopping_card_items#addToCartFromWishingList', as: 'addToCartFromWishingList'
  patch 'changeQuantity', to: 'shopping_card_items#changeQuantity', as: 'changeQuantity'
  # get 'checkout', to: 'shopping_card_items#checkout', as: 'checkout'
  post 'checkoutForm' ,to: 'shopping_card_items#checkoutForm' , as:'checkoutForm'
  patch 'cancleShoppingCard',to:'shopping_card_items#cancleShoppingCartItem',as:'cancleShoppingCartItem'


get 'applyCoupon', to:'shopping_card_items#applyCoupon'
get 'cancelCoupon', to:'shopping_card_items#cancelCoupon'



  resources :categories
 

  root to: 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products do
    resources :rate_reviews
  end
 
  
end
