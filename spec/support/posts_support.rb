module PostsSupport
  def to_new_post(post)
    click_link 'Maybyをつくろう'
    fill_in '名前', with: 'カラオケ'
    fill_in '遊び方', with: '歌ってみた'  
    find('label[for=post_num_of_people_一人]').click
    find('label[for=post_play_style_もくもく]').click
    click_button "Mayby作成"
  end
end

RSpec.configure do |config|
  config.include PostsSupport
end