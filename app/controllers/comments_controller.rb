class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id]).page(params[:page]).order(created_at: :desc)
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comments = Comment.where(post_id: @comment.post_id ).page(params[:page]).order(created_at: :desc)
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end