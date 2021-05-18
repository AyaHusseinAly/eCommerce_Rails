class AddImg1ToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :img1, :string , :default =>"download.png" 
    add_column :products, :img2, :string , :default =>"download.png"

  end
end
