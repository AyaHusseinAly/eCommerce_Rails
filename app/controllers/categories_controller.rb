class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])
        @categories=Category.all
        @products=@category.products
        @wishlist=WishingListItem.all
        @wish_found_flag=false
    end
end
