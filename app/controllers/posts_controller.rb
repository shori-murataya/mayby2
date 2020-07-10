class PostsController < ApplicationController
  def show
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(name: params[:name],howto: params[:howto])
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end
end
