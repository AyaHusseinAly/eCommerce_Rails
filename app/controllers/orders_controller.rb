class OrdersController < ApplicationController
    before_action do @categories=Category.all end

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
