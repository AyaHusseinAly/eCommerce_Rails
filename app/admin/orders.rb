ActiveAdmin.register Order do
  #checks if the user is seller to show it in the menu
  menu if: proc{ current_admin_user.role=="seller" }  

  #orders output by id asc.
  config.sort_order = 'id_asc'

  controller do
    def scoped_collection
      Order.where("store_id IN (?)",current_admin_user.stores.ids)
    end
  end
  #divides the orderes into categories
  scope :all
  scope :delivered
  scope :pending
  scope :confirmed

  #in show() add actions to confirm or mark as delivered to each order
  action_item :make_confirmed, only: :show do
    link_to "Confirm Order", make_confirmed_order_path(order),method: :put if order.status=="Pending"
  end
  action_item :make_delivered, only: :show do
    link_to "Mark As Delivered",make_delivered_order_path(order),method: :put if order.status="Confirmed"
  end

  member_action :make_confirmed, method: :put do
    order=Order.find(params[:id])
    order.update(status:"Confirmed")
    redirect_to order_path(order)
  end
  member_action :make_delivered, method: :put do
    order=Order.find(params[:id])
    order.update(status:"Delivered")
    redirect_to order_path(order)
  end

  #change index page
  index do
    selectable_column
    column "Order ID", :id
    column "User ID", :user_id
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :status, :coupon_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:status, :coupon_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
