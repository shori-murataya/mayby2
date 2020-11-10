require 'rails_helper'

RSpec.describe 'ポスト', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  context 'ログインしている場合' do
    before do
      sign_in user
      visit root_path
    end
    it '投稿をすること', js: true do  
      click_link 'Maybyをつくろう'
      fill_in '名前', with: 'カラオケ'
      fill_in '遊び方', with: '歌ってみた'
      find('.rspec_action_textarea').set('1人で歌い放題です')
      find('label[for=post_num_of_people_一人]').click
      find('label[for=post_play_style_もくもく]').click
      expect { click_button "Mayby作成" }.to change{ Post.count }.from(0).to(1) 
    end
    it '投稿を削除すること', js: true do  
      to_new_post post
      visit posts_path
      expect{
        page.accept_confirm do
          first('.rsepc_post-delete').click
        end
        expect(find('.rspec_notice').text).to eq '投稿を削除しました'
      }.to change{ Post.count }.by(-1) 
    end
    it '投稿を編集、更新すること', js: true do  
      to_new_post post
      visit posts_path
      find('.rspec_post-edit').click
      fill_in '名前', with: '一人カラオケ'
      fill_in '遊び方', with: 'オールナイト耐久戦'  
      find('.rspec_action_textarea').set('1人で悲しいです')
      find('label[for=post_num_of_people_二人]').click
      find('label[for=post_play_style_わいわい]').click
      expect{ click_button "更新" }.to_not change{ Post.count }
      expect(find('.rspec_notice').text).to eq '変更を保存しました'
    end
    it 'ユーザー詳細ページから投稿を編集すること', js: true do
      to_new_post post
      visit user_path user
      find('.rspec_post-tab').click
    
      find('.rspec_post-edit').click
      fill_in '名前', with: '一人カラオケ'
      fill_in '遊び方', with: 'オールナイト耐久戦'
      find('.rspec_action_textarea').set('1人で悲しいです')
      find('label[for=post_num_of_people_二人]').click
      find('label[for=post_play_style_わいわい]').click
      expect{ click_button "更新" }.to_not change{ Post.count }
      expect(find('.rspec_notice').text).to eq '変更を保存しました'
    end
    it '未記入があるとupdateページがrenderされること', js: true do
      to_new_post post
      visit posts_path
      find('.rspec_post-edit').click
      fill_in '名前', with: ''
      fill_in '遊び方', with: 'オールナイト耐久戦'  
      find('.rspec_action_textarea').set('1人で悲しいです')
      find('label[for=post_num_of_people_二人]').click
      find('label[for=post_play_style_わいわい]').click
      click_button "更新"  
      expect(page).to have_content '名前を入力してください'
    end
  end

  context '権限がないユーザーの場合' do
    let(:other_user) { FactoryBot.create(:user) }
    before do
      sign_in user
      visit root_path
    end
    it '投稿編集画面にアクセスすると一覧ページにリダイレクトされること' do
      to_new_post post
      visit posts_path
      visit edit_post_path other_user
      expect(current_path).to eq posts_path
      expect(find('.rspec_notice').text).to eq '権限がありません'
    end
  end

  context 'ログインしていない場合' do
    it '投稿画面アクセス時、ログインページへリダイレクトすること', js: true do 
      visit new_post_path
      expect(current_path).to eq new_user_session_path
      expect(find('.rspec_alert').text).to eq 'アカウント登録もしくはログインしてください。' 
     end
    it '編集画面アクセス時、ログインページへリダイレクトすること', js: true do 
      visit edit_post_path user
      expect(current_path).to eq new_user_session_path
      expect(find('.rspec_alert').text).to eq 'アカウント登録もしくはログインしてください。' 
    end
  end
  context '投稿を検索する場合' do
    before do
      sign_in user
      visit root_path
      to_new_post post
      visit posts_path
      find('.js_open').click
      sleep 1
    end
    it '名前で見つかること', js: true do
      fill_in '名前', with: 'カラオケ'
      click_button '検索'
      expect(page).to have_content 'カラオケ'
    end
    it 'プレイ人数で見つかること', js: true do
      find('label[for=q_num_of_people_eq_一人]').click
      click_button '検索'
      expect(page).to have_content '一人'
    end
    it '雰囲気で見つかること', js: true do
      find('label[for=q_play_style_eq_もくもく]').click
      click_button '検索'
      expect(page).to have_content 'もくもく'
    end
    it '検索が見つからないこと', js: true do
      fill_in '名前', with: 'ゲートボール'
      click_button '検索'
      expect(page).to_not have_content 'カラオケ'
    end
  end
end
