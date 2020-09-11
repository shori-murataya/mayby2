module PostsSupport
  def to_new_post(post)
    click_link 'Maybyをつくろう'
    fill_in '名前', with: 'カラオケ'
    fill_in '遊び方', with: '歌ってみた'  
    choose '一人'
    choose 'もくもく'
    click_button "Mayby作成"
  end
end

RSpec.configure do |config|
  config.include PostsSupport
end