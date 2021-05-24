class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many:stores
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  scope :admin, ->{where(role:"admin")}
  scope :seller, ->{where(role:"seller")}      
end
