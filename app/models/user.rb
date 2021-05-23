class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true , format: { with: /\A[a-zA-Z]+\z/,
  message: "only allows letters" }, uniqueness: true
  validates :password, :password_confirmation, presence: true , length: { minimum:6 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    # validates :email, presence: true
    # validates :password, presence: true , length: { minimum:6 }
    has_many :orders
    has_many :wishing_list_items
    has_many :rate_reviews
    has_many :shopping_card_items
    has_many :stores 
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
