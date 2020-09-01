require 'rails_helper'

RSpec.feature "ライク", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'ログイン状態の時、投稿してライクする' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    first('.new_mayby_button').click
    fill_in '名前', with: 'ウホホホホホホ！'
    fill_in '遊び方', with: 'ウキキキキキキキキ！'  
    choose '一人'
    choose 'もくもく'
    click_button "Mayby作成"

    first('#unlike-star').click
    expect(page).to have_content '人他'

  end
end
