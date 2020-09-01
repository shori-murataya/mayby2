require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context "確認済ユーザーとして" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "有効な属性値の場合" do
      it "ポストを追加できること" do
        post_params = FactoryBot.attributes_for(:post)
        sigin_in @user
        expect{
          post posts_path, params: { post: post_params}
      }.to change(@user.posts, :count).by(1)
      end
    end
  end
end
