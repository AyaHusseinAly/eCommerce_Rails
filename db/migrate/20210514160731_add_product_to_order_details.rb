class AddProductToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_details, :product, foreign_key: true
  end
end
