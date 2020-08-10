class UsersController < ApplicationController

  def index
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @users = @q.result.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    
    @user_comments = @user.comments.order(created_at: :desc)
  end
  
end
