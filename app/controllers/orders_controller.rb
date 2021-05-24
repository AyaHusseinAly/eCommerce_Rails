class OrdersController < ApplicationController
    before_action :authenticate_user!  # handle Guest access

    before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      
    end

    def index
        if params[:id]
       @orders= Order.where(user:current_user).order("created_at asc")
       @order= Order.find(params[:id])
        else
        @orders=nil
        @order=nil
        end
    end
end
