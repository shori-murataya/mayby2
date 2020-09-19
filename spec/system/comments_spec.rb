require 'rails_helper'

RSpec.describe "コメント", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  before do
    sign_in user
    visit root_path
    to_new_post post
    visit posts_path
  end
# find('.rspec_textarea').set('私もカラオケが好きです')
  it 'コメントすること', js: true do 
    click_link 'カラオケ'
    fill_in 'コメント', with: '私もカラオケが好きです'
    expect{
      click_button 'コメント'
    }.to change{ Comment.count }.from(0).to(1)
    expect(page).to have_content '私もカラオケが好きです'
  end

  it 'コメントを削除すること', js: true do
    click_link 'カラオケ'
    fill_in 'rspec_textarea', with: '私もカラオケが好きです'
    click_button 'コメント'
    sleep 2
    expect(page).to have_content '私もカラオケが好きです'

    expect{
      page.accept_confirm do
        find('.rspec_comment-delete').click
      end
    }.to change{ Comment.count }.from(1).to(0) 
    expect(page).to have_content '0件'
  end

  it 'ユーザ詳細ページからコメントを削除すること', js: true do

    click_link 'カラオケ'
    fill_in 'rspec_textarea', with: '私もカラオケが好きです'
    click_button 'コメント'
    visit user_path user
    find('.rspec_comment-tab').click
    expect{
      page.accept_confirm do
        find('.rspec_comment-delete').click
      end
      sleep 2
    }.to change{ Comment.count }.from(1).to(0) 
  end
end
