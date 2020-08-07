class PostsController < ApplicationController
  
  def index
    per_post = 2
    @q = Post.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @posts = @q.result.page(params[:page]).per(per_post).order(created_at: :desc)
    
  end

  def show
    per_comment = 5
    @post = Post.find_by(id: params[:id])
    @posts = Post.where(id: params[:id]).order(created_at: :desc)
    @comment = Comment.new
    @comments = Comment.where(post_id: params[:id]).page(params[:page]).per(per_comment).order(created_at: :desc)
  end 

  def new
    @post = Post.new
  end

  def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to posts_path
      else
        render "new"
      end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
      redirect_to posts_path 
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path
  end

private
def post_params
  params.require(:post).permit(:title, :howto, :num_of_people, :play_style, :user_id)
end

end
