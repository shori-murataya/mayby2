class Comment < ApplicationRecord
  MAXIMUM_LENGTH_CONTENT = 140
  validates :content, { presence: true, length: { maximum:MAXIMUM_LENGTH_CONTENT } }
  belongs_to :user
  belongs_to :post

  default_scope -> { order(created_at: :desc) }
  paginates_per 5  

end
