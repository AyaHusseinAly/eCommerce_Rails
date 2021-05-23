class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, prepend: true

    before_action :configure_permitted_parameters, if: :devise_controller?
  #   before_action do
  #     @categories=Category.all 
  #     @products=Product.all
  #     @brands=Brand.all
      
  # end

    
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password,:avatar)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar)}
    end


    # private
    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    #   devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar name username])
    # end

end



