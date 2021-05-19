class HomeController < ApplicationController
    before_action do
        @categories=Category.all 
        @products=Product.all
        @brands=Brand.all
        
    end
    
    before_action :authenticate_user!

    def index
        @products=Product.all.order("created_at desc").limit(12)

    end


    def searchInProduct
        if params[:q] != ""
            if params[:cat] == "All" and params[:cat] == "All" and params[:price] == "All" and params[:seller] == "All" and params[:q] !=""
                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                )
            else

                if params[:cat] == "All"
                    if params[:brand] == "All" 
                        if params[:price] == "All"
                            if  params[:seller] != "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(store_id: params[:seller])
                            end
                        elsif params[:price] != "All"
                            if params[:seller] == "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")).where(price: 0..499 ) 
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")).where(price: 500..1000 )
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")).where(price: 1000..5000 )
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")).where("price > ?", params[:price])
                                 end
                            elsif params[:seller] != "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(store_id: params[:seller]).where(price: 0..499 )  
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(store_id: params[:seller]).where(price: 500..1000 ) 
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(store_id: params[:seller]).where(price: 1000..5000 )
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(store_id: params[:seller]).where("price > ?", params[:price])
                                 end
                            end
                        end

                    ##!! second case !!##
                    elsif  params[:brand] != "All"
                        if  params[:price] == "All"
                            if params[:seller] == "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(brand_id: params[:brand])
                            elsif params[:seller] != "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(store_id: params[:seller] ,brand_id: params[:brand] )
                            end
                        elsif params[:price] != "All"   
                            if params[:seller] == "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand]) 
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand]) 
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand]) 
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand]) 
                                 end
                            elsif params[:seller] != "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand], store_id: params[:seller]) 
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand], store_id: params[:seller])
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand], store_id: params[:seller])
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(brand_id: params[:brand], store_id: params[:seller])
                                 end
                            end
                        end
                    end #end of brand if exist or not 
                ##!! Third case !!##

                elsif params[:cat] != "All"
                    if params[:brand] == "All" 
                        if  params[:price] == "All"
                            if params[:seller] == "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(category: params[:cat])
                            elsif params[:seller] != "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(store_id: params[:seller] ,category: params[:cat] )
                            end
                        elsif params[:price] != "All" 
                            if params[:seller] == "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat]) 
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat])
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat])
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat])
                                 end
                            elsif  params[:seller] != "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller]) 
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller])
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller])
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller])
                                 end
                            end
                        end
                    ## fourth probaply ####
                    elsif  params[:brand] != "All"
                        if params[:price] == "All"
                            if params[:seller] == "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(category: params[:cat], brand_id: params[:brand])
                            elsif params[:seller] != "All"
                                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                                    ).where(store_id: params[:seller] ,category: params[:cat],brand_id: params[:brand] )
                            end
                        elsif params[:price] != "All"  
                            if  params[:seller] == "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],brand_id: params[:brand])
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],brand_id: params[:brand])
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],brand_id: params[:brand])
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],brand_id: params[:brand])
                                 end
                            elsif  params[:seller] != "All"
                                if params[:price] == "0..499"
                                    @products1 = Product.where(price: 0..499 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                                 elsif params[:price] == "500..1000"
                                    @products1 = Product.where(price: 500..1000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                                 elsif params[:price] == "1000..5000"
                                    @products1 = Product.where(price: 1000..5000 ).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                                 elsif params[:price] == "5000"
                                    @products1 = Product.where("price > ?", params[:price]).where("title LIKE ?","%"+ params[:q] +"%").or(
                                        Product.where("description LIKE ?","%"+ params[:q] +"%")
                                        ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                                 end
                            end 
                        end
                    end

                end #end if cat is exist or not 
            end
############################ select without name ##################################  
        else
            ############!!!!!!!!!!!!!!!!!!!!################
            ## first probably ##
            if params[:cat] == "All"
                if params[:brand] == "All" 
                    if params[:price] == "All"
                        if  params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller])
                        end
                    elsif params[:price] != "All"
                        if params[:seller] == "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499 ) 
                            elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 )
                            elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 )
                            elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price])
                            end
                        elsif params[:seller] != "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(store_id: params[:seller], price: 0..499 ) 
                            elsif params[:price] == "500..1000"
                                @products1 = Product.where(store_id: params[:seller], price: 500..1000 )
                            elsif params[:price] == "1000..5000"
                                @products1 = Product.where(store_id: params[:seller], price: 1000..5000 )
                            elsif params[:price] == "5000"
                                @products1 = Product.where(store_id: params[:seller]).Product.where("price > ?", params[:price])
                            end
                        end
                    end

                ## second probably ##
                elsif  params[:brand] != "All"
                    if  params[:price] == "All"
                        if params[:seller] == "All"
                            @products1 = Product.where(brand_id: params[:brand])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller] ,brand_id: params[:brand] )
                        end
                    elsif params[:price] != "All"   
                        if params[:seller] == "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(brand_id: params[:brand],price: 0..499 ) 
                            elsif params[:price] == "500..1000"
                                @products1 = Product.where(brand_id: params[:brand], price: 500..1000 )
                            elsif params[:price] == "1000..5000"
                                @products1 = Product.where(brand_id: params[:brand], price: 1000..5000 )
                            elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(brand_id: params[:brand])
                            end
                        elsif params[:seller] != "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499 ).where(brand_id: params[:brand],store_id: params[:seller])
                            elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 ).where(brand_id: params[:brand],store_id: params[:seller])
                            elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 ).where(brand_id: params[:brand],store_id: params[:seller])
                            elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(brand_id: params[:brand],store_id: params[:seller])
                            end
                        end
                    end
                end #end of brand exist or not and category not exist
            
            ############  Third probably ################
            elsif params[:cat] != "All"
                if  params[:brand] == "All" 
                    if  params[:price] == "All"
                        if params[:seller] == "All"
                            @products1 = Product.where(category: params[:cat])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller] ,category: params[:cat] )
                        end
                    elsif params[:price] != "All" 
                        if params[:seller] == "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499).where(category: params[:cat])
                            elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 ).where(category: params[:cat])
                            elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 ).where(category: params[:cat])
                            elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(category: params[:cat])
                            end
                        elsif  params[:seller] != "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499).where(category: params[:cat],store_id: params[:seller])
                             elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 ).where(category: params[:cat],store_id: params[:seller])
                             elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 ).where(category: params[:cat],store_id: params[:seller])
                             elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(category: params[:cat],store_id: params[:seller])
                             end
                        end
                    end
                ############  Forth probably ################
                elsif  params[:brand] != "All"
                    if params[:price] == "All"
                        if params[:seller] == "All"
                            @products1 = Product.where(category: params[:cat], brand_id: params[:brand])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller] ,category: params[:cat],brand_id: params[:brand] )
                        end
                    elsif params[:price] != "All"  
                        if  params[:seller] == "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499 ).where(category: params[:cat],brand_id: params[:brand]) 
                             elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 ).where(category: params[:cat],brand_id: params[:brand]) 
                             elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 ).where(category: params[:cat],brand_id: params[:brand]) 
                             elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(category: params[:cat],brand_id: params[:brand]) 
                             end
                        elsif  params[:seller] != "All"
                            if params[:price] == "0..499"
                                @products1 = Product.where(price: 0..499 ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                             elsif params[:price] == "500..1000"
                                @products1 = Product.where(price: 500..1000 ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                             elsif params[:price] == "1000..5000"
                                @products1 = Product.where(price: 1000..5000 ).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                             elsif params[:price] == "5000"
                                @products1 = Product.where("price > ?", params[:price]).where(category: params[:cat],store_id: params[:seller],brand_id: params[:brand])
                             end
                        end 
                    end
                end #end of brand exist or not and category is exit 
            end #end of if category not exit 
        end #end of if name not exit 
##################################################################
        @products=Product.all
        @categories=Category.all 
        @brands=Brand.all   
    end
end 
