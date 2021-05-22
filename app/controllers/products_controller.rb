class ProductsController < ApplicationController
    before_action do
      @categories=Category.all 
      @products=Product.all
      @brands=Brand.all
      @seller = AdminUser.where(role: "seller")      
    end
    caches_page :show
    
    def index
        @products=Product.paginate(page: params[:page], per_page: 12)

      end

      def show
        ##user can review only purchased products and only once
        @can_review= false
        @no_prev_review

        if current_user.rate_reviews.where(product_id:params[:id]) == [] #he didn't reviewed it before
          @no_prev_review=true
        end  

        current_user.orders.where(status:"delivered").each { |o|  
          if o.order_details.where(product_id:params[:id]) != []
              @can_review=true
          end
        }


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

end
