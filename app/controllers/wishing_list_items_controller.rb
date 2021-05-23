class WishingListItemsController < ApplicationController
  before_action :authenticate_user!  # handle Guest access

      before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      
    end
    # def addToWishingList
    #   @product = Product.find(params[:id])
    #   if WishingListItem.find_by(product: @product,user:current_user) == nil
    #     WishingListItem.create(product: @product,user:current_user)
        
    #   end 
    #   redirect_to root_path
      
    # end
    def addToWishingListForm
      # render :json =>params['id']
      @product = Product.find(params['id'])
      if WishingListItem.find_by(product: @product,user:current_user) == nil
        WishingListItem.create(product: @product,user:current_user)
      end 
      redirect_to params['path']
      
    end
    def index
      @wishListItems=WishingListItem.where(user:current_user)
      @products=[]
      @wishListItems.each do |wishListItem|
          @products.push(wishListItem.product)
      end
      # render :json =>@products
      @categories=Category.all
    end
    # def destroy
    #   @product = Product.find(params[:id])
    #   @wishListItem=WishingListItem.find_by(product:@product)
    #   @wishListItem.destroy
    #   redirect_to wishing_list_items_path
    #   # render :json =>@wishListItem
  
    # end
    def destroyForm
      @product = Product.find(params['id'])
      @wishListItem=WishingListItem.find_by(product:@product)
      @wishListItem.destroy
      redirect_to params['path']
    end
  end
  
