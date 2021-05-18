class AddUserToStores < ActiveRecord::Migration[5.2]
  def change
   add_reference :stores, :user, foreign_key: true
  end
end
