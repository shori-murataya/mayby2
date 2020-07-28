class CommentsController < ApplicationController

  def create
    @comments = Comment.where(post_id: params[:post_id]).page(params[:page]).per(10)
    @post = Post.find(params[:post_id])
    @comment = Comment.new(
      content: params[ :content],
      user_id: @current_user.id,
      post_id: params[ :post_id])
      if @comment.save
        flash[:notice] = "コメントしました"
      else
        flash[:notice] = "投稿失敗。0~140字以内でお願いします。"
      end
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_id])
    @comments = Comment.where(post_id: @comment.post_id ).page(params[:page]).per(10)
    @comment.destroy
    flash[:notice] = "削除しました"
  end
end