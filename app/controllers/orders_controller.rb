class OrdersController < ApplicationController
    before_action :authenticate_user!  # handle Guest access

    before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      
    end

    def index
        @total=0
        @discount = 0
        @orders= Order.where(user:current_user).order("created_at asc")
        if @orders.length >0
            if params[:id]
                @order= Order.find(params[:id])
            else
                @order=@orders.last
            end
            if @order.coupon_id == 0 or @order.coupon_id == nil
                @discount = 0
            else
                @coupon =Coupon.find(@order.coupon_id)
                if @coupon.kind =="ratio"
                    @discount = @coupon.value *  0.01

                else 
                    @discount =@coupon.value

                end
            end
        else
            @orders=nil
            @order=nil
        end
    end

    def seller
        @user=User.find(params[:id])
        @admin_user=AdminUser.find_by(email:@user.email )
        @seller_stores = Store.where(admin_user_id:@admin_user)
        @orders =Order.where(store_id:@seller_stores,status:"Pending").paginate(page: params[:page], per_page: 12)
    end
end
