class AddCommentsLikesToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comments_count, :integer
    add_column :posts, :likes_count, :integer
  end
end
