class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :img
      t.integer :price
      t.integer :quantity
#      t.integer :brand_id
#      t.integer :category_id
#      t.integer :store_id

      t.timestamps
    end
  end
end
