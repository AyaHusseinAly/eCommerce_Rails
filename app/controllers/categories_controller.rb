class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])
        @categories=Category.all
        @products=@category.products
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      

    end
end
