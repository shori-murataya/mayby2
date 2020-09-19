class User < ApplicationRecord
  PER_USER_AT_INDEX = 3
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  acts_as_followable
  acts_as_follower
  validates :name, { presence: true }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  #must_be_ordered

  def current_user?(user)
    self.id == user.id
  end

  def followable?(user)
    self.id != user.id
  end
end
