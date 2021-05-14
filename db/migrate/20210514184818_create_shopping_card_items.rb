class CreateShoppingCardItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_card_items do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
