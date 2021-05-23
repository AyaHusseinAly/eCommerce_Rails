class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])
        @categories=Category.all
        @products=@category.products
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      

        @wishlist=WishingListItem.all
        @wish_found_flag=false
    end
end
