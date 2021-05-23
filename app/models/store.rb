class Store < ApplicationRecord
    has_many :products
    has_many :orders
    belongs_to :admin_user


end
