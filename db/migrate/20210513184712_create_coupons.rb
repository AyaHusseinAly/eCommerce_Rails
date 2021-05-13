class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.integer :value
      t.string :kind
      t.string :name
      t.timestamp :exp_date
      t.integer :usage_amount

      t.timestamps
    end
  end
end
