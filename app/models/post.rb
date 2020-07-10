class Post < ApplicationRecord
  validates :name, {presence: true}
  validates :howto, {presence: true}
end
