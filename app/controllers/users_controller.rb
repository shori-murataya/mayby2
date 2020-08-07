class UsersController < ApplicationController

  def index
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @users = @q.result.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: params[:id]).order(created_at: :desc)
    @user_comments = Comment.where(user_id: params[:id]).order(created_at: :desc)
  end
  
end
