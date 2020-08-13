class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow, :follow_list, :follower_list]

  def index
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @users = @q.result.order(created_at: :desc)
  end

  def show
    @user_comments = @user.comments.order(created_at: :desc)
  end

  def follow
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def unfollow
      current_user.stop_following(@user)
      redirect_to user_path(@user)
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
