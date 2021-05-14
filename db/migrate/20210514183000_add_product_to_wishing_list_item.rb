class AddProductToWishingListItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :wishing_list_items, :product, foreign_key: true
  end
end
