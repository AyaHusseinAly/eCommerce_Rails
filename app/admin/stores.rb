ActiveAdmin.register Store do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :summary, :user_id
  form do |f|
    inputs "Details" do
      input :name
      input :summary
      input :user_id, as: :select, collection: User.where(role:"seller")
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
