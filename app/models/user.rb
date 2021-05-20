class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :orders
    has_many :wishing_list_items
    has_many :rate_reviews
    has_many :shopping_card_items
    # has_many :stores 

  scope :seller, ->{where(role:"seller")}
  scope :buyer, ->{where(role:"buyer")}      
end
