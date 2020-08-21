class CommentsController < ApplicationController
  before_action :set_post_comments

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])#現在のユーザーがしたコメントIDの特定
    @user_comments = current_user.comments.order(created_at: :desc)#ユーザーのコメント一覧（Ajax at users/show）
    @comment.destroy!
  end

  private
  def set_post_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page]).order(created_at: :desc)
    #特定した投稿に対するコメント一覧(Ajax at posts/show)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end