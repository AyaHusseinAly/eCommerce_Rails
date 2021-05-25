class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true , format: { with: /\A[a-zA-Z]+\z/,
  message: "only allows letters" }, uniqueness: true
#   validates :password, :password_confirmation, presence: true , length: { minimum:6 }
  
  PASSWORD_FORMAT = /\A
  (?=.{6,})          # Must contain 6 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
/x


 validates :password, 
  presence: true, 
  length: { in: Devise.password_length }, 
  format: { with: PASSWORD_FORMAT, message: "should contain 6 or more characters and at least one digit and one lower case character and upper case character " }, 
  confirmation: true, 
  on: :create 

 validates :password, 
  allow_nil: true, 
  length: { in: Devise.password_length }, 
  format: { with: PASSWORD_FORMAT, message: "should contain 6 or more characters and at least one digit and one lower case character and upper case character " },  
  confirmation: true, 
  on: :update
 
  
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

    after_create :send_confirmation_email
    private
    def send_confirmation_email
        @user = User.last
        UserMaileMailer.welcome_email(@user).deliver_now

    end

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
