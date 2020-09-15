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
    it 'ログインすること', js: true do
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
end
