class Store < ApplicationRecord
    has_many :products
    belongs_to :user

end
