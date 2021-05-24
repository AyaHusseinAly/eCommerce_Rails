class ProductsController < ApplicationController
    before_action do
      @categories=Category.all 
      @products=Product.all
      @brands=Brand.all
      @seller = AdminUser.where(role: "seller") 
      @wishlist=WishingListItem.all
      @wish_found_flag=false     
    end
    caches_page :show
    
    def index
        @products=Product.paginate(page: params[:page], per_page: 12)
       

    end

      def show
        if user_signed_in?
            ##user can review only purchased products and only once
            @can_review= false
            @no_prev_review=false

            if current_user.rate_reviews.where(product_id:params[:id]) == [] #he didn't reviewed it before
              @no_prev_review=true
            end  

            current_user.orders.where(status:"Delivered").each { |o|  
              if o.order_details.where(product_id:params[:id]) != []
                  @can_review=true
              end
            }
         

          end

        @product = Product.find(params[:id])
        
        if @product.rate_reviews.count !=0
          number = @product.rate_reviews.count
          rating=0
          @product.rate_reviews.each { |n| rating+=n.rating.to_i }
          @avg=(rating/number)
          @avg_rate=@avg.round
          
        else
          @avg_rate=0          
        end  
   
      end

      def seller
        @user=User.find(params[:id])
        @admin_user=AdminUser.find_by(email:@user.email )
        @seller_stores = Store.where(admin_user_id:@admin_user)
        @products =Product.where(store_id:@seller_stores).paginate(page: params[:page], per_page: 12)
      end
      def cancleproduct
        
        if @product=Product.find(params['id']) and not OrderDetail.where(product:@product).length > 0 and not WishingListItem.where(product:@product).length > 0 and not ShoppingCardItem.where(product:@product).length > 0
          @product.destroy
        else
          # render :json =>"can't destroy orders"
          flash.notice = "can't delete this product"
        end 
        redirect_to root_path 
        
      end
      def new
        @current_admin_user=AdminUser.find_by(email:current_user.email )
        @product=Product.new
      end
      def create
        @product=Product.create(product_params)
        # @product.img.attach(params[:product][:img])
        # @product.images.attach(params[:product][:images])

        if @product.save
          redirect_to @product
        else
          render 'new'
        end

      end

      def product_params
        params.require(:product).permit(:title, :description,:price, :quantity,:store_id,:brand_id,:category_id,:img,images:[])
      end

      def destroy
        Product.find(params[:id]).destroy
        redirect_to products_path
      end
   
end
