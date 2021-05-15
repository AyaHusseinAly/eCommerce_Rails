class HomeController < ApplicationController
    before_action :authenticate_user!

    def index
        @products=Product.all.order("created_at desc").limit(12)
        @categories=Category.all
    end
        
end
