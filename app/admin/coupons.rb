ActiveAdmin.register Coupon do
  
  menu if: proc{ current_admin_user.role=="admin" }  
  config.sort_order = 'id_asc'
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :value, :kind, :name, :exp_date, :usage_amount
  #
  form do |f|
    inputs "Details" do
      input :name
      input :value
      input :kind, as: :select, collection: ["fixed","percentage"], default: "fixed"
      input :exp_date
      input :usage_amount

    end
    actions 
  end
  # or
  #
  # permit_params do
  #   permitted = [:value, :kind, :name, :exp_date, :usage_amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
