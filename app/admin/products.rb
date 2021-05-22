ActiveAdmin.register Product, as: "All Products" do
  
  controller do
    def scoped_collection
      Product.where("store_id IN (?)",current_admin_user.stores.ids)
    end
  end
  menu if: proc{ current_admin_user.role=="seller" }  
  config.sort_order = 'id_asc'
  # action_item :make_store do
  #   link_to 'Create a store', new_admin_store_path
  # end
  # scope_to do
  #    Product.all do |product|
  #     proc{product.store.admin_users.in?(current_admin_user)}
  #   end
  # end
  

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :img, :price, :quantity, :brand_id, :store_id, :category_id
  #
  form do |f|
    if current_admin_user.stores.length == 0
        div class: 'admin_container' do
          span "You don't have any stores yet."
          div "Wait for an admin to assign you to a store."
        end
    else
    inputs "Product Details" do
      input :title, label: "Product Name"
      input :description, label: "Product Description"
      input :store, as: :select, collection: current_admin_user.stores
      input :brand
      input :category
      input :img , label: "Product Image"
      input :price
      input :quantity, label: "Quantity In Stock"
    end
    actions  
  end
end
action_item :view_product, only: :show do
  link_to "See this product in website",view_product_admin_product_path(product),method: :get 
end

member_action :view_product, method: :get do
  product=Product.find(params[:id])
  # AdminUser.create!(name:user.name , email:user.email , password:user.password , password_confirmation:user.password_confirmation, role:"seller")
  # user.update(role:"seller")
  redirect_to product_path(product)
end
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :img, :price, :quantity, :brand_id, :store_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
