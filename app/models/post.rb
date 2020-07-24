class Post < ApplicationRecord
  validates :name, {presence: true}
  validates :howto, {presence: true, length: {maximum:300}}
  validates :user_id, {presence: true}
  validates :count, {presence: true}
  validates :difficulty, {presence: true}

  belongs_to :user

  def user
    return User.find_by(id: self.user_id)
  end

  def comments
    return Comment.where(post_id: self.id)
  end



end
