class AddStoreToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :store, foreign_key: true
  end
end
