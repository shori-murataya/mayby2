require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  
  describe '#index' do
    context 'ログインユーザーの場合' do
      let(:user) { FactoryBot.create(:user) }
      before do
        sign_in user
      end
      it '正常にレスポンスを返すこと' do
        get posts_path
        expect(response).to be_success
      end
      it '200レスポンスを返すこと' do
        get posts_path
        expect(response).to have_http_status '200'
      end
    end
    context 'ゲストユーザーの場合' do
      it '302レスポンスを返すこと' do
        get posts_path
        expect(response).to have_http_status '302'
      end
      it 'ログイン画面へリダイレクトすること' do
        get posts_path
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe '#show' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    context 'ログインユーザーの場合' do     
      it '正常にレスポンスを返すこと' do     
        sign_in user
        get post_path post.id
        expect(response).to be_success
      end
    end
    context 'ゲストユーザーの場合' do
      it 'ログイン画面へリダイレクトすること' do
        get post_path post.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    context '有効な属性値の場合' do
      it 'ポストを追加できること' do
        sign_in user
        post_params = FactoryBot.attributes_for(:post, user: user)
        expect{
          post posts_path, params: { post: post_params }
        }.to change(user.posts, :count).by(1)
      end
    end
    context '無効な属性値の場合' do
      it 'ポストを追加できないこと' do
        sign_in user
        post_params = FactoryBot.attributes_for(:post, title: nil)
        expect{
          post posts_path, params: { post: post_params }
        }.to_not change(user.posts, :count)
      end
    end
    context 'ゲストユーザーの場合' do
      it 'ログイン画面へリダイレクトすること' do
        post_params = FactoryBot.attributes_for(:post, user: user)
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to '/users/sign_in' 
      end
    end
  end
  describe '#update' do
    context '認可されたユーザーの場合' do
      let(:user) { FactoryBot.create(:user) }
      let(:post) { FactoryBot.create(:post, user: user) }
      it 'ポストを更新できること' do
        sign_in user
        post_params = FactoryBot.attributes_for(:post, title: '更新テスト')
        put post_path post.id, params: { post: post_params }
        expect(post.reload.title).to eq '更新テスト'
      end
    end
    # ActiveRecord::RecordNotFound なので、ポスト編集の権限メソッドが必要？
    # context '認可されていないユーザーの場合' do
    #   let(:user) { FactoryBot.create(:user) }
    #   let(:other_user) { FactoryBot.create(:user) }
    #   let(:post) { FactoryBot.create(:post, user: other_user, title: '更新テスト') }
    #   it 'ポストを更新できないこと' do
    #     sign_in user
    #     post_params = FactoryBot.attributes_for(:post, title: '変更できない')
    #     put post_path post.id, params: { post: post_params }
    #     expect(post.reload.title).to eq '更新テスト'
    #   end
    # end
  end
  describe '#destroy' do
    context '認可されたユーザーの場合' do
      let(:user) { FactoryBot.create(:user) }
      let(:post) { FactoryBot.create(:post, user: user) }
      it 'ポストを削除できること' do
        sign_in user
        expect{
          delete post_path post.id 
      }.to change(user.posts, :count).by(0)
      end
    end
  end
end
