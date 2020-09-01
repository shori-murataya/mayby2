require 'rails_helper'

RSpec.feature 'POST投稿', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'ログイン状態の時に投稿する' do  
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    first('.new_mayby_button').click
    fill_in '名前', with: 'ウホホホホホホ！'
    fill_in '遊び方', with: 'ウキキキキキキキキ！'  
    choose '一人'
    choose 'もくもく'
    expect { click_button "Mayby作成" }.to change{Post.count}.from(0).to(1) 
  end

  scenario 'ログイン状態の時に投稿し削除する', js: true do  
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    first('.new_mayby_button').click
    fill_in '名前', with: 'ウホホホホホホ！'
    fill_in '遊び方', with: 'ウキキキキキキキキ！'  
    choose '一人'
    choose 'もくもく'
    expect { click_button "Mayby作成" }.to change{Post.count}.from(0).to(1)

    expect{
      page.accept_confirm do
        first('#post-delete').click
      end
    }.to change{Post.count}.from(1).to(0)
   


  end
end
