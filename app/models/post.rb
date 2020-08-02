class Post < ApplicationRecord
  MAXIMUM_LENGTH_HOWTO = 300
  validates :name, { presence: true}
  validates :howto, { presence: true, length: { maximum:MAXIMUM_LENGTH_HOWTO } }
  validates :user_id, { presence: true }
  validates :count, { presence: true }
  validates :difficulty, { presence: true }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  default_scope -> {order(created_at: :desc)}
  
end
