require 'rails_helper'

RSpec.feature 'POST投稿', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  before do
    sign_in user
    visit root_path
  end

  scenario '新しい投稿をする', js: true do  
    click_link 'Maybyをつくろう'
    fill_in '名前', with: 'カラオケ'
    fill_in '遊び方', with: '歌ってみた'  
    choose '一人'
    choose 'もくもく'
    expect { click_button "Mayby作成" }.to change{Post.count}.from(0).to(1) 
  end

  scenario '投稿を削除する', js: true do  
    to_new_post post
    visit posts_path

    expect{
      page.accept_confirm do
        first('#post-delete').click
      end
      expect(page).to have_content '投稿を削除しました'
    }.to change{ Post.count }.by(-1) 
  end

  scenario '投稿を編集、更新する', js: true do  
    to_new_post post
    visit posts_path

    find('#post-edit').click
    fill_in '名前', with: '一人カラオケ'
    fill_in '遊び方', with: 'オールナイト耐久戦'  
    choose '二人〜'
    choose 'わいわい'
    expect{
    click_button "更新" 
    expect(page).to have_content '変更を保存しました' 
    }.to_not change{ Post.count }   
  end

  scenario 'ユーザー詳細ページから投稿を編集する', js:true do
    to_new_post post
    visit user_path user
    find('#post-tab').click

    find('#post-edit').click
    fill_in '名前', with: '一人カラオケ'
    fill_in '遊び方', with: 'オールナイト耐久戦'  
    choose '二人〜'
    choose 'わいわい'
    expect{
      click_button "更新" 
      expect(page).to have_content '変更を保存しました' 
    }.to_not change{ Post.count }    
  end
end
