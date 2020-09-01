require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let(:like) { FactoryBot.build(:like, user_id: user.id, post_id: post.id) }
  let(:like2) { FactoryBot.build(:like, user_id: user.id, post_id: post.id) }
 
  describe "バリデーションの検証" do    
    it "有効なライクであること" do
      expect(like).to be_valid
    end

    it "ユーザーIDなしは無効であること" do
      like.user_id = nil
      expect(like).to_not be_valid
    end

    it "ポストIDなしは無効であること" do
      like.post_id = nil
      expect(like).to_not be_valid
    end

    it "一つの投稿に２回ライクは無効であること" do
      like.post_id = 2
      like2.post_id = 2
      expect(like2).to_not be_valid
    end
  end
end
