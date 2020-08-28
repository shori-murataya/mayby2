require 'rails_helper'

RSpec.describe Like, type: :model do
  #有効なライク
  it "is valid like" do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user_id: user.id)
    like = Like.create(
      user_id: user.id,
      post_id: post.id,
    )
    expect(like).to be_valid
  end
  #無効なライク
  describe "invalid likes" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, user_id: @user.id)
    end
    #ユーザーなしは無効
    it "invalid without a user" do
      like = Like.new(
        user_id: nil,
        post_id: @post.id,
      )
      expect(like).to_not be_valid
    end
    #ポストなしは無効
    it "invalid without a user" do
      like = Like.new(
        user_id: @post.id,
        post_id: nil,
      )
      expect(like).to_not be_valid
    end
    #ユーザーは一つの投稿に対して一回のみライクできる
    it "does only 1 like per post" do
      Like.create(user_id: @user.id, post_id: 2)
      duplicated_like = Like.create(user_id: @user.id, post_id: 2)
      expect(duplicated_like).to_not be_valid
    end
  end
end
