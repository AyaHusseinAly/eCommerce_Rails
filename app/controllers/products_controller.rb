class ProductsController < ApplicationController
    before_action do @categories=Category.all end
    def index
        @products=Product.paginate(page: params[:page], per_page: 12)
      end

      def show
        
        @product = Product.find(params[:id])
      end
end
