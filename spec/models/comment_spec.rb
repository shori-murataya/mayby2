require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "バリデーションの検証" do

    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:comment) { FactoryBot.build(:comment, user: user, post: post) }
    
    it "有効なコメントであること" do
      comment.save!
      expect(comment).to be_valid
    end

    it "ユーザーIDなしは無効であること" do
      comment.user_id = nil
      expect(comment).to_not be_valid
    end
    it "ポストIDなしは無効であること" do
      comment.post_id = nil
      expect(comment).to_not be_valid
    end
    it "コメントなしは無効であること" do
      comment.content = nil
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end
    it "140文字を超えると無効であること" do
      comment.content = "#{"A"*141}"
      comment.valid?
      expect(comment.errors[:content]).to include("は140文字以内で入力してください")
    end
  end

  describe "#comment_user?" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:comment) { FactoryBot.create(:comment, user_id: user.id, post_id: post.id) }

    context "コメントをしたユーザーである場合" do
      it "trueを返すこと" do
        expect(comment.comment_user?(user)).to eq true
      end
    end
    context "コメントをしたユーザーでない場合" do
      it "falseを返すこと" do
        expect(comment.comment_user?(other_user)).to eq false
      end
    end
  end
end
