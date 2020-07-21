class CommentsController < ApplicationController

  def new
    @comment = Comment.new 
    @post = Post.find_by(id: params[:post_id])
  end
  def create
    @comment = Comment.new(
      content: params[ :content],
      user_id: @current_user.id,
      post_id: params[ :post_id])
      if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to("/posts/#{@comment.post_id}/show")
      else
        flash[:notice] = "投稿失敗。0~140字以内でお願いします。"
        redirect_to("/comments/#{@comment.post_id}/new")
      end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to("/posts/#{@comment.post_id}/show")
  end
end