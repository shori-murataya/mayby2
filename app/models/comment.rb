class Comment < ApplicationRecord
  validates :content, {presence: true, length: {maximum:140}}
  
def comuser
  return User.find_by(id: self.user_id)
end

def compost
  return Post.find_by(id: self.post_id)
end

end
