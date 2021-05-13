class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status
      t.integer :coupon_id

      t.timestamps
    end
  end
end
