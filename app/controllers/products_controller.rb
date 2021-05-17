class ProductsController < ApplicationController
    before_action do @categories=Category.all end
    def index
        @products=Product.paginate(page: params[:page], per_page: 12)

      end

      def show
        @product = Product.find(params[:id])
        number = @product.rate_reviews.count
        rating=0
        @product.rate_reviews.each { |n| rating+=n.rating.to_i }
        @avg=(rating/number)
        @avg_rate=@avg.round
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
