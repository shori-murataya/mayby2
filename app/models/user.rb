require "open-uri"
class User < ApplicationRecord
  PER_USER_AT_INDEX = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :omniauthable
  
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, { presence: true }
  validates :image, blob: { content_type: :image, size_range: 1..5.megabytes }

  # setting for acts_as_follower
  acts_as_followable
  acts_as_follower

  #must_be_ordered

  def current_user?(user)
    self.id == user.id
  end

  def followable?(user)
    self.id != user.id
  end

  def image_url
    if self.image.attached?
      image
    else
      "/assets/no_image.jpg"
    end
  end

  # setting for omniauth
  def self.first_or_create_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.email = auth.info.email
      user.email = User.dummy_email(auth) if user.provider == "twitter"
      avatar = open("#{auth.info.image}")
      user.image.attach(io: avatar, filename: "user_avatar.jpg")
    end
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end  
    
end
