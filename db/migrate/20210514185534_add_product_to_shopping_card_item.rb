class AddProductToShoppingCardItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :shopping_card_items, :product, foreign_key: true
  end
end
