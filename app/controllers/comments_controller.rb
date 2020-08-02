class CommentsController < ApplicationController

  def create
    #非同期でコメントするため
    @comments = Comment.where(post_id: params[:post_id]).page(params[:page])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(
      content: params[ :content],
      user_id: @current_user.id,
      post_id: params[ :post_id])
      @comment.save
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_id])
    @comments = Comment.where(post_id: @comment.post_id ).page(params[:page])
    @comment.destroy
  end

  def user_come_destroy
    @comment = Comment.find_by(id: params[:comment_id])
    @comments = Comment.where(user_id: @comment.user_id ).page(params[:page])
    @comment.destroy
  end
end