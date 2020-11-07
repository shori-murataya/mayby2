require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  let(:user) { FactoryBot.create(:user) }
  context '新規ユーザーの場合' do
    it '登録できること' do
      visit new_user_registration_path
      fill_in '名前', with: '春日'
      fill_in 'メールアドレス', with: 'kasuga@example.com'
      fill_in 'パスワード', with: 'wakabayashi'
      fill_in 'パスワード確認', with: 'wakabayashi'
      click_button '新規登録'
      expect(find('.rspec_notice').text).to eq 'アカウント登録が完了しました。'
    end
    it '登録できないこと' do
      visit new_user_registration_path
      fill_in '名前', with: ' '
      fill_in 'メールアドレス', with: ' '
      fill_in 'パスワード', with: ' '
      fill_in 'パスワード確認', with: ' '
      click_button '新規登録'
      expect(page).to have_content '3 件のエラーが発生したため ユーザー は保存されませんでした。'
    end
  end
  context 'ログインしていない場合' do
    it 'ログインすること' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end
  end
  context 'ログインしている場合' do
    it 'ログアウトすること', js: true do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      find('.rspec_session-destroy').click
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  context 'プロフィール画像を設定する場合' do
    it '画像がアップロードされること' do
      sign_in user
      visit edit_user_registration_path
      attach_file 'プロフィール画像', "#{Rails.root}/spec/files/test.jpg"
      fill_in '現在のパスワード', with: user.password
      click_button '更新' 
      visit users_path
      expect(page).to have_selector "img[src$='test.jpg']"
    end
  end
  context 'プロフィール画像を設定しない場合' do
    it 'デフォルト画像が設定されること' do
      sign_in user
      visit edit_user_registration_path
      fill_in '現在のパスワード', with: user.password
      click_button '更新' 
      visit users_path
      expect(page).to have_selector "img[src$='no_image.jpg']"
    end
  end

  context 'フォロー関連のボタンを押した場合' do
    let(:other_user) { FactoryBot.create(:user) }
    before do
      sign_in user
      visit users_path
      visit user_path other_user
    end
    it 'フォローすること', js: true do
      expect{
        click_on "フォローする"
        sleep 2
      }.to change{ user.following.count }.from(0).to(1) 
    end
    it 'フォローを解除すること', js: true do
      click_on "フォローする"
      sleep 2
      expect{
        click_on "フォロー外す"
        sleep 2
      }.to change{ user.following.count }.from(1).to(0) 
    end
  end

  context 'フォローボタンを押された場合' do
    let(:user) { FactoryBot.create(:user) }
    let(:follower_user) { FactoryBot.create(:user) }
    before do
      sign_in follower_user
      visit users_path
      visit user_path user
    end
    it 'フォロワーが増えること', js: true do
      expect{
        click_on "フォローする"
        sleep 2
      }.to change{ user.followers.count }.from(0).to(1) 
    end
    it 'フォロワーが減ること', js: true do
      click_on "フォローする"
      sleep 2
      expect{
        click_on "フォロー外す"
        sleep 2
      }.to change{ user.followers.count }.from(1).to(0) 
    end
  end

  context 'ユーザー検索をする場合' do
    before do
      sign_in user
      visit users_path
    end
    it 'ユーザーが見つかること', js: true do
      fill_in 'rspec_user_search', with: 'Taro'
      click_button '検索'
      expect(page).to have_content 'Taro'
    end
    it 'ユーザーが見つからないこと', js: true do
      fill_in 'rspec_user_search', with: 'Hanako'
      click_button '検索'
      expect(page).to_not have_content 'Taro'
      expect(page).to_not have_content 'Hanako'
    end
  end
end
