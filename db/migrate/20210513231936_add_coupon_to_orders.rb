class AddCouponToOrders < ActiveRecord::Migration[5.2]
  def change
    # add_reference :orders, :coupon, foreign_key: true
    add_reference :orders,  foreign_key: true
  end
end
