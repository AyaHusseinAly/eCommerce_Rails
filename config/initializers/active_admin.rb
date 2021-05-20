ActiveAdmin.setup do |config|
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.load_paths = [File.expand_path('app/admin', Rails.root)]
  # if :current_admin_user.role=="admin"
  #   config.site_title="Admin Panel"
  # elsif :current_admin_user.role=="seller"
  #   config.site_title="Seller Panel"
  # end
  
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.comments = false
end
