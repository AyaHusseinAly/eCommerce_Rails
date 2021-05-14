class CreateWishingListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :wishing_list_items do |t|


      t.timestamps
    end
  end
end
