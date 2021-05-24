class CategoriesController < ApplicationController
    before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller") 
        @wishlist=WishingListItem.all
        @wish_found_flag=false     
    end
    def show
        @category = Category.find(params[:id])
        # @categories=Category.all
        @products=@category.products
        # @wishlist=WishingListItem.all
        # @wish_found_flag=false
    end
end
