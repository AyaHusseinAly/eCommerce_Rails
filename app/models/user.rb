class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :orders
    has_many :wishing_list_items
    has_many :rate_reviews
    has_many :shopping_card_items

    ##### stores has been moved to AdminUser model 
    # AdminUser.where(role:'seller')
    # has_many :stores 

  scope :seller, ->{where(role:"seller")}
  scope :buyer, ->{where(role:"buyer")}      

    # has_many :stores 
    has_one_attached :avatar  

  after_commit :add_default_avatar, on: %i[create update]

    def avatar_thumbnail
      if avatar.attached?  
         avatar.variant(resize: "250x200!").processed
        # resource.avatar.attach(params[:avatar])
        
      else
        "/default_profile.jpg"
      end
    end 
    
  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app','assets','images','default_profile.jpg'
          )
        ), filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      ) 
    end
  end       
end
