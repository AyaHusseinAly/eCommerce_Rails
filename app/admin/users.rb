ActiveAdmin.register User do
  menu if: proc{ current_admin_user.role=="admin" }  

  scope :all
  scope :seller
  scope :buyer

  action_item :make_seller, only: :show do
    link_to "Make This User A Seller",make_seller_admin_user_path(user),method: :get if user.role!="seller"
  end
  action_item :remove_seller, only: :show do
    link_to "Turn Seller to Buyer",remove_seller_admin_user_path(user),method: :get if user.role!="buyer"
  end

  member_action :make_seller, method: :get do
    user=User.find(params[:id])
    AdminUser.create!(name:user.name , email:user.email , password: "password" , password_confirmation:"password", role:"seller")
    user.update(role:"seller")
    redirect_to admin_user_path(user)
  end
  member_action :remove_seller, method: :get do
    user=User.find(params[:id])
    seller=AdminUser.find_by(email:user.email)
    seller.delete
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
  after_create do
    @seller=User.all.last
    if @seller.role=="seller"
      AdminUser.create!(name:@seller.name,email:@seller.email,password: :password,password_confirmation: :password,role:"seller")
    end
  end
  

  # or
  #
  # permit_params do
  #   permitted = [:name, :role, :address, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
