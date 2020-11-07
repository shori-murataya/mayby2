class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow, :follow_list, :follower_list]

  def index
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @users = @q.result.page(params[:page]).per(User::PER_USER_AT_INDEX).order(created_at: :desc)
  end

  def show
    @user_comments = @user.comments.order(created_at: :desc)
  end

  def follow_list
  end

  def follower_list
  end

private

  def set_user
    @user = User.find(params[:id])
  end

end
