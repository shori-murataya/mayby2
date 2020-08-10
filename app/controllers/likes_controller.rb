class LikesController < ApplicationController
  before_action :set_post, only:[:create, :destroy]

  def create
    @like = @post.likes.build(user_id: current_user.id)
    #@like = current_user.likes.build(post_id: params[:id])
    @like.save!
  end

  def destroy
    @like = @post.likes.find_by(user_id: current_user.id)
    @like.destroy!
  end

  def show
    @likes = Like.where(post_id:params[:post_id]).order(created_at: :desc)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end