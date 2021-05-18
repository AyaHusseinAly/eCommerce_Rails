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
            elsif params[:cat] != "All"
                @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                    Product.where("description LIKE ?","%"+ params[:q] +"%")
                ).where(category: params[:cat])
            end

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
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(price: params[:price])
                        elsif params[:seller] != "All"
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(store_id: params[:seller], price: params[:price])
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
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(brand_id: params[:brand], price: params[:price])
                        elsif params[:seller] != "All"
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(brand_id: params[:brand], price: params[:price],store_id: params[:seller])
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
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(category: params[:cat], price: params[:price])
                        elsif  params[:seller] != "All"
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(category: params[:cat], price: params[:price],store_id: params[:seller])
                        end
                    end
                
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
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(category: params[:cat], price: params[:price],brand_id: params[:brand])
                        elsif  params[:seller] != "All"
                            @products1 = Product.where("title LIKE ?","%"+ params[:q] +"%").or(
                                Product.where("description LIKE ?","%"+ params[:q] +"%")
                                ).where(category: params[:cat], price: params[:price],store_id: params[:seller],brand_id: params[:brand])
                        end 
                    end
                end

            end #end if cat is exist or not 

        ################### select without name ################# 
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
                            @products1 = Product.where(price: params[:price])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller], price: params[:price])
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
                            @products1 = Product.where(brand_id: params[:brand], price: params[:price])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(brand_id: params[:brand], price: params[:price],store_id: params[:seller])
                        end
                    end
                end #end of brand exist or not and category not exist
            
            ############!!!!!!!!!!!!!!!!!!!!################
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
                            @products1 = Product.where(category: params[:cat], price: params[:price])
                        elsif  params[:seller] != "All"
                            @products1 = Product.where(category: params[:cat], price: params[:price],store_id: params[:seller])
                        end
                    end

                elsif  params[:brand] != "All"
                    if params[:price] == "All"
                        if params[:seller] == "All"
                            @products1 = Product.where(category: params[:cat], brand_id: params[:brand])
                        elsif params[:seller] != "All"
                            @products1 = Product.where(store_id: params[:seller] ,category: params[:cat],brand_id: params[:brand] )
                        end
                    elsif params[:price] != "All"  
                        if  params[:seller] == "All"
                            @products1 = Product.where(category: params[:cat], price: params[:price],brand_id: params[:brand])
                        elsif  params[:seller] != "All"
                            @products1 = Product.where(category: params[:cat], price: params[:price],store_id: params[:seller],brand_id: params[:brand])
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
