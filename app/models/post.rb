class Post < ApplicationRecord
  validates :name, {presence: true}
  validates :howto, {presence: true}
  validates :user_id, {presence: true}
end
