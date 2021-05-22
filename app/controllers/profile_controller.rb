class ProfileController < ApplicationController
    before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      
      end
    def show
        
    end

end
