ActiveAdmin.register Coupon do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :value, :kind, :name, :exp_date, :usage_amount
  #
  # or
  #
  # permit_params do
  #   permitted = [:value, :kind, :name, :exp_date, :usage_amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
