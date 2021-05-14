class AddUserToShoppingCardItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :shopping_card_items, :user, foreign_key: true
  end
end
