class AddAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string , :default =>"defualt.png"

  end
end
