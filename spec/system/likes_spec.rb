require 'rails_helper'

RSpec.describe "ライク", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  before do
    sign_in user
    visit root_path
    to_new_post post
    visit posts_path
  end

  it '投稿にライクすること', js: true do
    expect{
      first('.rspec_unlike-star').click
    }.to change{ Like.count }.from(0).to(1)  
    expect(page).to have_content '人他'
  end

  it '投稿のライクを取り消すこと', js: true do
    first('.rspec_unlike-star').click
    expect(page).to have_content '人他'

    expect{
      first('.rspec_like-star').click
    }.to change{ Like.count }.from(1).to(0)  
    expect(page).to have_content '0'
  end

  it '投稿の詳細画面でライクすること', js: true do
    expect{
      click_link 'カラオケ'
      find('.rspec_unlike-star').click
    }.to change{ Like.count }.from(0).to(1)
    expect(page).to have_content '人他'
  end
end
