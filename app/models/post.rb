class Post < ApplicationRecord
  validates :name, {presence: true}
  validates :howto, {presence: true, length: {maximum:300}}
  validates :user_id, {presence: true}
  validates :count, {presence: true}
  validates :difficulty, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

end
