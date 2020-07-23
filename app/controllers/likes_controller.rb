class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to("/posts/#{params[:post_id]}/show")
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}/show")
  end

  def index_create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to("/posts/index")
  end

  def index_destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/index")
  end

  def index
    @likes = Like.where(post_id:params[:post_id])
  end

end