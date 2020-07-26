class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    #redirect_to("/posts/#{params[:post_id]}/show")
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    #redirect_to("/posts/#{params[:post_id]}/show")
  end

  def index
    @likes = Like.where(post_id:params[:post_id])
  end

end