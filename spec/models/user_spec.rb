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

    it "画像サイズが5MB以上は無効であること" do
      user.image = fixture_file_upload("#{Rails.root}/spec/files/large_image.jpg")
      user.valid?
      expect(user.errors[:image]).to include("を5MB以下のサイズにしてください。")
    end

    it "画像以外のファイルは無効であること" do
      user.image = fixture_file_upload("#{Rails.root}/spec/files/test.html")
      user.valid?
      expect(user.errors[:image]).to include("のファイル形式が不正です。")
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

  describe "#followable?" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    context "ログインユーザーがフォロー可能なユーザーの場合" do
      it "trueを返すこと" do
        expect(other_user.followable?(user)).to eq true
      end
    end
    context "ログインユーザーがフォロー不可能なユーザーの場合" do
      it "falseを返すこと" do
        expect(user.followable?(user)).to eq false
      end
    end
  end

  describe '#image_url' do

    let(:has_image_user) { FactoryBot.create(:user) }
    let(:no_image_user) { FactoryBot.create(:user) }
    let(:has_image_post) { FactoryBot.create(:post, user: has_image_user) }
    let(:no_image_post) { FactoryBot.create(:post, user: no_image_user) } 
    
    context 'ユーザー画像が選択されている場合' do
      it 'ユーザー画像を返すこと' do
        has_image_user.image = fixture_file_upload("#{Rails.root}/spec/files/test.jpg")
        expect(has_image_user.image_url).to eq has_image_user.image
      end
    end
    context 'ユーザー画像が選択されていない場合' do
      it 'no_image.jpgを返すこと' do
        expect(no_image_user.image_url).to eq "/user_images/no_image.jpg"
      end
    end
    context 'post関連ページでユーザー画像が選択されている場合' do
      it 'ユーザー画像を返すこと' do
        has_image_user.image = fixture_file_upload("#{Rails.root}/spec/files/test.jpg")
        expect(has_image_post.user.image_url).to eq has_image_user.image
      end
    end
    context 'post関連ページでユーザー画像が選択されていない場合' do
      it 'no_image.jpgを返すこと' do
        expect(no_image_post.user.image_url).to eq "/user_images/no_image.jpg"
      end
    end

  end
end
