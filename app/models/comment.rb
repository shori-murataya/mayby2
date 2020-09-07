class Comment < ApplicationRecord
  MAXIMUM_LENGTH_CONTENT = 140
  PER_COMMENT_AT_SHOW = 5
  validates :content, { presence: true, length: { maximum:MAXIMUM_LENGTH_CONTENT } }

  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  #must_be_ordered

  def comment_user?(user)
    self.user_id == user.id 
  end
end
