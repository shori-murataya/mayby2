require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  #有効なメイビー(ポスト)
  it "valid Mayby(post)" do
    post = FactoryBot.create(:post, user_id: @user.id)
    expect(post).to be_valid
  end

  #タイトルなしは無効
  it "invalid without a title" do
    @post.title = nil
    @post.valid?
    expect(@post.errors[:title]).to include("を入力してください") 
  end

  #遊び方なしは無効
  it "invalid without a howto" do
    @post.howto = nil
    @post.valid?
    expect(@post.errors[:howto]).to include("を入力してください") 
  end

  #参加人数なしは無効
  it "invalid without a num_of_people" do
    @post.num_of_people = nil
    @post.valid?
    expect(@post.errors[:num_of_people]).to include("を入力してください") 
  end

  #雰囲気なしは無効
  it "invalid without a play_style" do
    @post.play_style = nil
    @post.valid?
    expect(@post.errors[:play_style]).to include("を入力してください") 
  end
end
