class RemoveUserFromStores < ActiveRecord::Migration[5.2]
  def change
    remove_reference :stores, :user, foreign_key: true
  end
end
