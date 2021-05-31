class ShoppingCardItemsController < ApplicationController


  @@discount =0
  @@coupon_used_id = 0
 
  before_action :authenticate_user!  # handle Guest access

      before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        @seller = AdminUser.where(role: "seller")      
    end

    def index
        @buyerProducts=ShoppingCardItem.where(user:current_user)
        @categories=Category.all
        @total=0
        @discount=@@discount

      

        # render :json =>@buyerProducts
      end
      # def addToCart
      #       @product = Product.find(params[:id])
      #       # @product.quantity=@product.quantity-1
      #       # @product.save
      #       # render :json =>@user
      #       @shop=ShoppingCardItem.find_by(product: @product,user:current_user)
            
      #       if @shop &&  @shop.quantity <  @product.quantity
      #           # @shop=ShoppingCardItem.find_by(product: @product,user:current_user)
      #           # check quantity
              
      #           @shop.quantity=@shop.quantity+1
      #           @shop.save
              
      #       elsif  not  @shop
      #           ShoppingCardItem.create(product: @product,user:current_user,quantity:1)
      #       end  
              
      #       redirect_to root_path
      #       # redirect_back
      # end
      def addToCartForm
        @product = Product.find(params['id'])
        @shop=ShoppingCardItem.find_by(product: @product,user:current_user)
        if @shop &&  @shop.quantity <  @product.quantity
            @shop.quantity=@shop.quantity+1
            @shop.save
        elsif  not  @shop
            ShoppingCardItem.create(product: @product,user:current_user,quantity:1)
        end  
          
        redirect_to params['path']

      end
      def addToCartFromWishingList
        @product = Product.find(params[:id])
        # render :json =>@user
        if ShoppingCardItem.find_by(product: @product,user:current_user)
            @shop=ShoppingCardItem.find_by(product: @product,user:current_user)
            @shop.quantity=@shop.quantity+1
            @shop.save
        else    
            ShoppingCardItem.create(product: @product,user:current_user,quantity:1)
        end 
        @wishListItem=WishingListItem.find_by(product:@product)
        @wishListItem.destroy 
        redirect_to wishing_list_items_path
      end
      def changeQuantity
        @contain=params[:shopping_card_item]
        # render :json=>@contain[:quantity].to_i+1
        @shoppingcarditem=ShoppingCardItem.find(@contain[:id])
        # @diffChangeProductQuantity=@shoppingcarditem.quantity-@contain[:quantity]
        # @shoppingcarditem.product.quantity=@shoppingcarditem.product.quantity+(@shoppingcarditem.quantity-@contain[:quantity].to_i)
        # @shoppingcarditem.product.save
        @quantity=@contain[:quantity]
        if @shoppingcarditem.product.quantity>@quantity.to_i and @quantity.to_i>0
          @shoppingcarditem.quantity=@contain[:quantity]
          @shoppingcarditem.save
        end
        redirect_to shopping_card_item_index_path 
        # redirect_to :back
      end
      # def checkout
      #   #  render :json=>params[:shopping_card_items]

      #   @products=ShoppingCardItem.where(user:current_user)
      #   @order=Order.create(status:"Pending",user:current_user)
      #   @products.each do |product|
      #       @orderDetail=OrderDetail.create(paid_price:product.product.price,product:product.product,order:@order,amount:product.quantity)
      #       @orderDetail.save
      #       @orderDetail.product.quantity=@orderDetail.product.quantity-@orderDetail.amount
      #       @orderDetail.product.save

      #   end
      #   @products.delete_all
      #   redirect_to shopping_card_item_index_path  

      # end
      def checkoutForm
        #render :json=>params['couponCode']
        @coupon_id= @@coupon_used_id
        while ShoppingCardItem.where(user:current_user).length > 0 do
          @first_store=ShoppingCardItem.find_by(user:current_user).product.store
          @store_products=Product.where(store:@first_store)
          @products=ShoppingCardItem.where(user:current_user,product:@store_products)
          
            # @coupon=Coupon.find(@coupon_id)
            if@coupon_id==0
              @order=Order.create!(status:"Pending",user:current_user,store:@first_store)
            else
              @order=Order.create!(status:"Pending",user:current_user,store:@first_store,coupon_id: @coupon_id)
            end
          @products.each do |product|
            @orderDetail=OrderDetail.create(paid_price:product.product.price,product:product.product,order:@order,amount:product.quantity)
            @orderDetail.save
            @orderDetail.product.quantity=@orderDetail.product.quantity-@orderDetail.amount
            @orderDetail.product.save
          end
          @products.delete_all
          @@discount =0
          @@coupon_used_id = 0
        end
      
        redirect_to shopping_card_item_index_path  
      end

      # def checkout
      #   while ShoppingCardItem.where(user:current_user).length > 0 do
      #     @first_store=ShoppingCardItem.find_by(user:current_user).product.store
      #     @store_products=Product.where(store:@first_store)
      #     @products=ShoppingCardItem.where(user:current_user,product:@store_products)
      #     @order=Order.create!(status:"Pending",user:current_user,store:@first_store)
      #     @products.each do |product|
      #       @orderDetail=OrderDetail.create(paid_price:product.product.price,product:product.product,order:@order,amount:product.quantity)
      #       @orderDetail.save
      #       @orderDetail.product.quantity=@orderDetail.product.quantity-@orderDetail.amount
      #       @orderDetail.product.save
      #     end
      #     @products.delete_all
      #   end
      #   redirect_to shopping_card_item_index_path  

      # end
      def cancleShoppingCartItem
        @contain=params[:shopping_card_item]
        @shoppingcarditem=ShoppingCardItem.find(@contain[:id])
        # @shoppingcarditem.product.quantity=@shoppingcarditem.product.quantity+@shoppingcarditem.quantity
        # @shoppingcarditem.product.save
        @shoppingcarditem.destroy
        redirect_to shopping_card_item_index_path 
        # render :json=>@shoppingcarditem
      end

      def applyCoupon
        @coupon = Coupon.find_by(name:params[:code])
        @@discount = 0
        @coupon_used_before =0
        if @coupon == nil
          flash.alert = " your entered coupon not found"
        else
        
        

          @orders= Order.where(user:current_user).order("created_at asc")
          @orders.each do |order|
            if order.coupon_id == @coupon.id
              flash.alert = " You have used this coupon befor"
              @coupon_used_before =1
            end
          end  

            if @coupon_used_before == 0

              if @coupon.usage_amount <= 0
                flash.alert = "  This Coupon reached to limit of used"
                @coupon.usage_amount = @coupon.usage_amount + 1
                @coupon.save
              elsif @coupon.exp_date < Date.today
                flash.alert = " This Coupon expired"
                @coupon.usage_amount = @coupon.usage_amount + 1
                @coupon.save
                
              else
                @coupon.usage_amount = @coupon.usage_amount - 1
                @coupon.save
                puts @coupon.usage_amount 
                if @coupon.kind =="ratio"
                  @@discount = @coupon.value *  0.01
      
                else 
                  @@discount =@coupon.value
      
                end
                @@coupon_used_id=@coupon.id
      
              end



            end
          end
          
      
        
        redirect_to shopping_card_item_index_path 
      end

      def cancelCoupon
        if @@coupon_used_id==0
          flash.alert = "  You have not Enter any  Any Coupon Codes"
        else

          @canceledCoupon =Coupon.find(@@coupon_used_id)
          @canceledCoupon.usage_amount =  @canceledCoupon.usage_amount + 1
          @canceledCoupon.save
          @@discount = 0
          @@coupon_used_id=0
        end


        redirect_to shopping_card_item_index_path 
      end




end

