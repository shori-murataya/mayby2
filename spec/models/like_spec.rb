require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:like) { FactoryBot.build(:like, user: user, post: post) }
  let(:like2) { FactoryBot.build(:like, user: user, post: post) }
 
  describe "バリデーションの検証" do    
    it "有効なライクであること" do
      expect(like).to be_valid
    end

    it "ユーザーIDなしは無効であること" do
      like.user_id = nil
      like.valid?
      expect(like.errors[:user_id]).to include 'を入力してください'
    end

    it "ポストIDなしは無効であること" do
      like.post_id = nil
      like.valid?
      expect(like.errors[:post_id]).to include 'を入力してください'
    end

    it "一つの投稿に２回ライクは無効であること" do
      like.post_id = 2
      like2.post_id = 2
      expect(like).to_not be_valid
    end
  end
end
