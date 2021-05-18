class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action do @categories=Category.all end


    def index
        @products=Product.all.order("created_at desc").limit(12)
    end

    def searchInProduct
            @products = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                Product.where("description LIKE ?","%"+ params[:q] +"%")
            )
    end
end 
