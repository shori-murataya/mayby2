class Like < ApplicationRecord
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}

  belongs_to :user

  def likeusers
    return User.find_by(id: self.user_id)
  end

  def likeposts
    return Post.find_by(id: self.post_id)
  end
end
