require 'rails_helper'

RSpec.feature "コメント", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  before do
    sign_in user
    visit root_path
    to_new_post post
    visit posts_path
  end

  scenario 'コメントする', js: true do 
    click_link 'カラオケ'
    fill_in 'textarea1', with: '私もカラオケが好きです'
    click_button 'コメント'
    expect{
      expect(page).to have_content '私もカラオケが好きです'
    }.to change{ Comment.count }.by(1)
  end

  scenario 'コメントを削除する', js: true do
    click_link 'カラオケ'
    fill_in 'textarea1', with: '私もカラオケが好きです'
    click_button 'コメント'

    expect{
      page.accept_confirm do
        find('#comment-delete-button').click
      end
      expect(page).to have_content '0件'
    }.to change{ Comment.count }.by(0)
  end

  scenario 'ユーザ詳細ページからコメントを削除する', js: true do

    click_link 'カラオケ'
    fill_in 'textarea1', with: '私もカラオケが好きです'
    click_button 'コメント'
    
    visit user_path user
    find('#comment-tab').click

    expect{
      page.accept_confirm do
        find('#comment-delete-button').click
      end
    }.to change{ Comment.count }.by(0)


  end


end
