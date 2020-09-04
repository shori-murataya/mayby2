require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'ログインする', js: true do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    
  end
  # scenario 'ログアウトする', js:true do
  #   visit new_user_session_path
  #   fill_in 'メールアドレス', with: user.email
  #   fill_in 'パスワード', with: user.password
  #   click_button 'ログイン'

  #   click_on 'ログアウト', visible: false, match: :first
  #   expect(page).to have_content 'ログアウトしました。'
  # end
end
