require 'rails_helper'

RSpec.describe User, type: :model do
  #名前、メールアドレス、パスワードがあれば有効
  it "valid with a name, email, and password" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  #無効なユーザー
  describe "invalid users" do
    before do
      @user = FactoryBot.build(:user)
    end

    #名前がなければ無効
    it "invalid without a name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors[:name]).to include("を入力してください")
    end

    #メールアドレスがなければ無効
    it "invalid without a email" do
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("が入力されていません。")
    end

    #パスワードがなければ無効
    it "invalid without a password" do
      @user.password = nil
      @user.valid?
      expect(@user.errors[:password]).to include("が入力されていません。")
    end

    #重複したメールアドレスは無効
    it "invalid duplicated email address" do
      FactoryBot.create(:user, email: "taro@example.com")
      @user.email = "taro@example.com"
      @user.valid?
      expect(@user.errors[:email]).to include("は既に使用されています。")
    end

    #パスワードは６文字以上でないと無効
    it "invalid password under 6 character" do
      @user.password = "12345"
      @user.valid?
      expect(@user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
  end
end
