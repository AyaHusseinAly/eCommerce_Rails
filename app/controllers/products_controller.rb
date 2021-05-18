class ProductsController < ApplicationController
    before_action do @categories=Category.all end
    def index
        @products=Product.paginate(page: params[:page], per_page: 12)

      end

      def show
        ##user can review only purchased products
        @can_review= false
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

      def rate
        @product = Product.find(params[:id])
        @rate_review = @product.rate_reviews.new
        @rate_review.content="whatever for test"
        @rate_review.rating=params[:rating]
        if user_signed_in?
            @rate_review.user=current_user
        end
        @rate_review.save()

        redirect_to product_path(@product)
        
      end
end
