class HomeController < ApplicationController
    before_action :authenticate_user!

    def index
        @products=Product.all.order("created_at desc").limit(12)
        @categories=Category.all
    end

    def searchInProduct
        if params[:q] != ""
            if params[:cat] == "All" and params[:cat] == "All" and params[:price] == "All" and params[:seller] == "All" and params[:q] !=""
                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                )
            end

        else
            if params[:cat] == "All" and params[:brand] == "All" 
                if params[:price] == "All" and params[:seller] != "All"
                    @products1 = Product.where(store_id: params[:seller])
                elsif params[:price] != "All" and params[:seller] == "All"
                    @products1 = Product.where(price: params[:price])
                elsif params[:price] != "All" and params[:seller] != "All"
                    @products1 = Product.where(store_id: params[:seller], price: params[:price])
                end

            elsif params[:cat] == "All" and params[:brand] != "All" 
                if params[:price] == "All" and params[:seller] == "All"
                    @products1 = Product.where(brand_id: params[:brand])
                elsif params[:price] == "All" and params[:seller] != "All"
                    @products1 = Product.where(store_id: params[:seller] ,brand_id: params[:brand] )
                elsif params[:price] != "All" and params[:seller] == "All"
                    @products1 = Product.where(brand_id: params[:brand], price: params[:price])
                elsif params[:price] != "All" and params[:seller] != "All"
                    @products1 = Product.where(brand_id: params[:brand], price: params[:price],store_id: params[:seller])
                end
        
            elsif params[:cat] != "All" and params[:brand] == "All" 
                if params[:price] == "All" and params[:seller] == "All"
                    @products1 = Product.where(category: params[:cat])
                elsif params[:price] == "All" and params[:seller] != "All"
                    @products1 = Product.where(store_id: params[:seller] ,category: params[:cat] )
                elsif params[:price] != "All" and params[:seller] == "All"
                    @products1 = Product.where(category: params[:cat], price: params[:price])
                elsif params[:price] != "All" and params[:seller] != "All"
                    @products1 = Product.where(category: params[:cat], price: params[:price],store_id: params[:seller])
                end

            elsif params[:cat] != "All" and params[:brand] != "All" 
                if params[:price] == "All" and params[:seller] == "All"
                    @products1 = Product.where(category: params[:cat], brand_id: params[:brand])
                elsif params[:price] == "All" and params[:seller] != "All"
                    @products1 = Product.where(store_id: params[:seller] ,category: params[:cat],brand_id: params[:brand] )
                elsif params[:price] != "All" and params[:seller] == "All"
                    @products1 = Product.where(category: params[:cat], price: params[:price],brand_id: params[:brand])
                elsif params[:price] != "All" and params[:seller] != "All"
                    @products1 = Product.where(category: params[:cat], price: params[:price],store_id: params[:seller],brand_id: params[:brand])
                end
            end
        end
#################################################################
        # elsif params[:cat] != "All" and params[:price] != "All" and params[:price] != "All"and params[:q] ==""
        #     @products = Product.where(category: params[:cat], price: params[:price])

        # elsif  params[:price] != "All" and params[:q] ==""
        #     @products = Product.where(price: params[:price])

        # elsif  params[:cat] != "All" and params[:q] ==""
        #     @products = Product.where(category: params[:cat])
           
            # end
##################################################################
        @products=Product.all
        @categories=Category.all 
        @brands=Brand.all
            
    end
end 
