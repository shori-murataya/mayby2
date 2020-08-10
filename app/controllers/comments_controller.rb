class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.where(post_id: params[:post_id]).page(params[:page]).order(created_at: :desc)
    @comment = current_user.comments.build(comment_params)
    @comment.save!
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comments = Comment.where(post_id: @comment.post_id ).page(params[:page]).order(created_at: :desc)
    @user_comments = Comment.where(user_id: @comment.user_id).order(created_at: :desc)
    @comment.destroy!
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end