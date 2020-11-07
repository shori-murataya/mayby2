class User < ApplicationRecord
  PER_USER_AT_INDEX = 3
  MAX_IMAGE_FILE_SIZE = 1..5.megabytes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [ :facebook, :google_oauth2, :twitter]
  
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, { presence: true }
  validates :image, blob: { content_type: :image, size_range: MAX_IMAGE_FILE_SIZE }

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #must_be_ordered

  def current_user?(user)
    self.id == user.id
  end

  #フォローする
  def follow(other_user)
    following << other_user
  end
    
  #フォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #フォローしてたらtrue
    def following?(other_user)
      following.include?(other_user)
    end
  
  def followable?(user)
    self.id != user.id
  end

  def image_url
    if self.image.attached?
      image
    else
      "/user_images/no_image.jpg"
    end
  end

  # Setting for omniauth
  def self.first_or_create_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.email = auth.info.email
      user.email = User.dummy_email(auth) if user.provider == "twitter"
      url = URI.parse("#{auth.info.image}")
      avatar = url.open
      user.image.attach(io: avatar, filename: "user_avatar.jpg")
    end
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end  
    
end
