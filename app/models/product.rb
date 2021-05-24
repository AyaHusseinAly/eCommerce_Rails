class Product < ApplicationRecord
    belongs_to :brand 
    belongs_to :category
    belongs_to :store
    has_many :rate_reviews
    has_many :order_details
    validates :title, :description, :price, presence: true
    has_many_attached :images
end
