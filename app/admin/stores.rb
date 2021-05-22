ActiveAdmin.register Store do
  scope_to :current_admin_user
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # scope_to do
  #   Store.where(admin_user_id:current_admin_user.id)
  # end
  config.sort_order = 'id_asc'
  permit_params :name, :summary, :admin_user_id
  form do |f|
    inputs "Details" do
      input :name
      input :summary
      input :admin_user_id, as: :select, collection: AdminUser.where(role:"seller")
    end
    actions 
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :summary, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
