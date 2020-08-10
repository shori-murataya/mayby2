class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  #must_be_ordered
end
