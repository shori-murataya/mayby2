require 'rails_helper'

RSpec.describe User, type: :model do

  describe "バリデーションの検証" do

    let(:user) { FactoryBot.build(:user) }

    it "名前、メールアドレス、パスワードがあれば有効であること" do
      user.save!
      expect(user).to be_valid
    end
  
    it "名前なしは無効であること" do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  
    it "メールアドレスなしは無効であること" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end
  
    it "パスワードなしは無効であること" do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end
  
    it "メールアドレスの重複は無効であること" do
      FactoryBot.create(:user, email: "taro@example.com")
      user.email = "taro@example.com"
      user.valid?
      expect(user.errors[:email]).to include("は既に使用されています。")
    end
  
    it "パスワードが６文字未満は無効であること" do
      user.password = "12345"
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
  end

  describe "#current_user?" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    
    context "ログインユーザーと同じユーザーの場合" do
      it "trueを返すこと" do
        expect(user.current_user?(user)).to eq true 
      end
    end
    context "ログインユーザーと同じユーザーではない場合" do
      it "falseを返すこと" do
        expect(user.current_user?(other_user)).to eq false 
      end
    end
  end
end
