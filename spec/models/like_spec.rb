require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:like) { FactoryBot.build(:like, user: user, post: post) }
 
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
  end
  context '一つの投稿に対しての重複のライク' do
    let!(:valid_like) { FactoryBot.create(:like, user: user, post: post) }
    let!(:invalid_like) { FactoryBot.build(:like, user: user, post: post) }
    it "いいねができないこと" do
      expect(invalid_like).to_not be_valid
    end
  end
end
