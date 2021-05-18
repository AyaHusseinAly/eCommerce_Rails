ActiveAdmin.register User do
  scope :all
  scope :seller
  scope :buyer

  action_item :make_seller, only: :show do
    link_to "Make This User A Seller",make_seller_admin_user_path(user),method: :put if user.role!="seller"
  end
  action_item :make_buyer, only: :show do
    link_to "Make This Seller A Buyer",make_buyer_admin_user_path(user),method: :put if user.role!="buyer"
  end

  member_action :make_seller, method: :put do
    user=User.find(params[:id])
    user.update(role:"seller")
    redirect_to admin_user_path(user)
  end
  member_action :make_buyer, method: :put do
    user=User.find(params[:id])
    user.update(role:"buyer")
    redirect_to admin_user_path(user)
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :role, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  permit_params :name, :role, :email, :password, :password_confirmation
  
  form do |f|
    inputs "Details" do
      input :name
      input :role, as: :select, collection: ['buyer','seller']
      input :email
      input :password
      input :password_confirmation
    end
    actions  
  end
  
  # or
  #
  # permit_params do
  #   permitted = [:name, :role, :address, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
