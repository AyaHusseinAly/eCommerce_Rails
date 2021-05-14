class User < ApplicationRecord
    has_many :orders
    has_many :wishing_list_items
    has_many :shopping_card_items
    has_many :stores    
end
