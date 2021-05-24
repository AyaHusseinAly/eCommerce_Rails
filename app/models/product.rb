class Product < ApplicationRecord
    belongs_to :brand 
    belongs_to :category
    belongs_to :store
    has_many :rate_reviews
    validates :title, :description, :price, presence: true
    has_one_attached :img
    has_one_attached :img1
    has_one_attached :img2



    
end
