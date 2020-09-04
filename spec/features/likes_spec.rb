require 'rails_helper'

RSpec.feature "ライク", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  before do
    sign_in user
    visit root_path
    to_new_post post
    visit posts_path
  end

  scenario '投稿にライクする', js: true do
    expect{
      first('#unlike-star').click
      expect(page).to have_content '人他'
    }.to change{Like.count}.from(0).to(1)  
  end
  scenario '投稿のライクを取り消す（怪しい）', js: true do
    first('#unlike-star').click
    expect{
      first('#like-star').click
      expect(page).to have_content '0'
    }.to change{Like.count}.from(1).to(0)
  end

  scenario '投稿の詳細画面でライクする', js: true do
    expect{
      click_link 'カラオケ'
      find('#unlike-star').click
      expect(page).to have_content '人他'
    }.to change{Like.count}.from(0).to(1)
  end
end
