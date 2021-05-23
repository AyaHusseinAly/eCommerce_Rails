class AddAdminUserToStores < ActiveRecord::Migration[5.2]
  def change
    add_reference :stores, :admin_user, foreign_key: true
  end
end
