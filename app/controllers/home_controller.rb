class HomeController < ApplicationController
    before_action :authenticate_user!

    def index
        @products=Product.all.order("created_at desc").limit(12)
        @categories=Category.all
    end

    def searchInProduct
            @products = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                Product.where("description LIKE ?","%"+ params[:q] +"%")
            )
            @categories=Category.all  
    end
end 
