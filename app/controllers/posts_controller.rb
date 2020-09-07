class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy ]
  before_action :require_post_created_user!, only: [:edit, :update, :destroy]
  def index
    @q = Post.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @posts = @q.result.page(params[:page]).per(Post::PER_POST_AT_INDEX).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build
    @comments = @post.comments.page(params[:page]).per(Comment::PER_COMMENT_AT_SHOW).order(created_at: :desc)
  end 

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "変更を保存しました"
      redirect_to posts_path
    else
      render :edit 
    end
  end

  def destroy
    @post.destroy!
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

private

  def post_params
    params.require(:post).permit(:title, :howto, :num_of_people, :play_style)
  end

  def set_post
    @post = current_user.posts.find(params[:id]) rescue nil
  end

  def require_post_created_user!
    if @post == nil 
      redirect_to posts_path, notice: '権限がありません'
    end
  end
end