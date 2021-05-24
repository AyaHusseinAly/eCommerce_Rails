ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
   
  content title: proc { I18n.t("active_admin.dashboard") } do
    # index do
      # stores_orders = Order.group(:store_id).where("store_id IN (?)",current_admin_user.stores.ids).count
      # json_data = []
      # stores_orders.each do |key, value|
      #   json_data << {
      #     label: key,
      #     data: value
      #   }
      # end
      if current_admin_user.role=="seller"
      @products= Product.where("store_id IN (?)",current_admin_user.stores.ids)
      render partial: 'charts',locals:{
        sellers_products: @products,
        
      }
    end
    # end
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
    # columns do
    #   column
    # end


    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
