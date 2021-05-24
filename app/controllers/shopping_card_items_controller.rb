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
        @shoppingcarditem.quantity=@contain[:quantity]
        @shoppingcarditem.save
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
          if @coupon_id == 0
            @order=Order.create!(status:"Pending",user:current_user,store:@first_store)
          else
            # @coupon=Coupon.find(@coupon_id)
            @order=Order.create!(status:"Pending",user:current_user,store:@first_store,coupon_id:@coupon_id)
          end  
          @products.each do |product|
            @orderDetail=OrderDetail.create(paid_price:product.product.price,product:product.product,order:@order,amount:product.quantity)
            @orderDetail.save
            @orderDetail.product.quantity=@orderDetail.product.quantity-@orderDetail.amount
            @orderDetail.product.save
          end
          @products.delete_all
        end
        redirect_to shopping_card_item_index_path  
      end
      def checkout
        while ShoppingCardItem.where(user:current_user).length > 0 do
          @first_store=ShoppingCardItem.find_by(user:current_user).product.store
          @store_products=Product.where(store:@first_store)
          @products=ShoppingCardItem.where(user:current_user,product:@store_products)
          @order=Order.create!(status:"Pending",user:current_user,store:@first_store)
          @products.each do |product|
            @orderDetail=OrderDetail.create(paid_price:product.product.price,product:product.product,order:@order,amount:product.quantity)
            @orderDetail.save
            @orderDetail.product.quantity=@orderDetail.product.quantity-@orderDetail.amount
            @orderDetail.product.save
          end
          @products.delete_all
        end
        redirect_to shopping_card_item_index_path  

      end
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
        #@coupon=params[:q]
        @coupon = Coupon.find_by(name:params[:code])
        @@coupon_used_id=@coupon.id



        puts"*********************************"
        puts @@discount
        puts @coupon.usage_amount

        if @coupon.usage_amount <= 0
          puts "used finished"
          flash.alert = "  coupon reached to limit of used"
        #elsif @coupon.exp_date < Date.today

        # flash.alert = " This Coupon expired"


          
        else
          @coupon.usage_amount = @coupon.usage_amount - 1
          @coupon.save
          puts @coupon.usage_amount 
          if @coupon.kind =="t"
            puts "t"
            @@discount = @coupon.value *  0.01

          else 
            puts "fixed"
            @@discount =@coupon.value

          end
        end
        
        redirect_to shopping_card_item_index_path 
        



      end

      def cancelCoupon
        puts "cancelCoupon"
        @canceledCoupon =Coupon.find(@@coupon_used_id)
        puts @canceledCoupon
        @canceledCoupon.usage_amount =  @canceledCoupon.usage_amount + 1
        @canceledCoupon.save
        @@discount = 0


        redirect_to shopping_card_item_index_path 
      end




end

