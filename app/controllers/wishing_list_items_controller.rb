class WishingListItemsController < ApplicationController
    def addToWishingList
      @product = Product.find(params[:id])
      if WishingListItem.find_by(product: @product,user:current_user) == nil
        WishingListItem.create(product: @product,user:current_user)
        
      end 
      redirect_to root_path
      
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
    def destroy
      @product = Product.find(params[:id])
      @wishListItem=WishingListItem.find_by(product:@product)
      @wishListItem.destroy
      redirect_to wishing_list_items_path
      # render :json =>@wishListItem
  
    end
  end
  
