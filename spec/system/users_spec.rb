require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  let(:user) { FactoryBot.create(:user) }
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
end
