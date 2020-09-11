require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "バリデーションの検証" do

    let(:user) { FactoryBot.create(:user) } 
    let(:post) { FactoryBot.build(:post) } 

    it "有効なメイビー(ポスト)であること" do
      post = FactoryBot.create(:post, user_id: user.id)
      expect(post).to be_valid
    end
  
    it "タイトルなしは無効であること" do
      post.title = nil
      post.valid?
      expect(post.errors[:title]).to include("を入力してください") 
    end
  
    it "遊び方なしは無効であること" do
      post.howto = nil
      post.valid?
      expect(post.errors[:howto]).to include("を入力してください") 
    end
  
    it "参加人数なしは無効であること" do
      post.num_of_people = nil
      post.valid?
      expect(post.errors[:num_of_people]).to include("を入力してください") 
    end
  
    it "雰囲気なしは無効であること" do
      post.play_style = nil
      post.valid?
      expect(post.errors[:play_style]).to include("を入力してください") 
    end
  end

  describe "#created_user?" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
  
    context "ログインユーザーと同じユーザーの場合" do
      it "trueを返すこと" do
        expect(post.created_user?(user)).to eq true 
      end
    end
    context "ログインユーザーと同じユーザーではない場合" do
      it "falseを返すこと" do
        expect(post.created_user?(other_user)).to eq false 
      end
    end 
  end

  describe '#unliking_user?' do
    let(:user) { FactoryBot.create(:user) }
    let(:like_post) { FactoryBot.create(:post) }
    let(:unlike_post) { FactoryBot.create(:post) }
    let!(:like) { FactoryBot.create(:like, user: user, post: like_post) }
    
    context 'ライクしていないポストの場合' do
      it 'trueを返すこと' do
        expect(unlike_post.unliking_user?(user)).to eq true
      end
    end
    context 'ライクしているポストの場合' do
      it 'falseを返すこと' do
        expect(like_post.unliking_user?(user)).to eq false
      end
    end
  end
end
