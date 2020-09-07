class Post < ApplicationRecord
  MAXIMUM_LENGTH_HOWTO = 300
  PER_POST_AT_INDEX = 2
  
  validates :title, { presence: true }
  validates :howto, { presence: true, length: { maximum:MAXIMUM_LENGTH_HOWTO } }
  validates :num_of_people, { presence: true }
  validates :play_style, { presence: true }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #must_be_ordered
  def created_user?(user)
    self.user_id == user.id
  end

  def liking_user?(user)
    user.likes.find_by(post_id: self.id)
  end
end
