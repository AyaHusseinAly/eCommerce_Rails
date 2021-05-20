class RateReviewsController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        @rate_review = @product.rate_reviews.new
        @rate_review.content=review_params["content"]
        @rate_review.rating=review_params["rating"]
        if user_signed_in?
            @rate_review.user=current_user
        end
        @rate_review.save()

        redirect_to product_path(@product)
    end
     
    private
    def review_params
      params.require(:rate_review).permit(:content,:rating)
    end
end
