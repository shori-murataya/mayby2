class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      name: params[:name],
      howto: params[:howto],
      user_id: @current_user.id)
    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end
end
