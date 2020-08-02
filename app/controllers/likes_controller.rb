class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
  end

  def index
    @likes = Like.where(post_id:params[:post_id]).order(created_at: :desc)
  end

end