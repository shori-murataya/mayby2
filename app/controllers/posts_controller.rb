class PostsController < ApplicationController
  before_action :access_right_post,{only:[:edit]}
  before_action :no_login_post,{only:[:new]}

  def access_right_post
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def no_login_post
      if @current_user == nil
        flash[:notice] = "権限がありません"
        redirect_to("/")
      end
  end

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
      user_id: @current_user.id,
      count: params[:count],
      difficulty: params[:difficulty]
      )
    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    @post.howto = params[:howto]
    @post.count = params[:count]
    @post.difficulty = params[:difficulty]
    if @post.save
      flash[:notice] = "編集完了"
      redirect_to("/posts/index")
    else
      flash[:notice] = "編集失敗"
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def desc
    @posts = Post.all.order(created_at: :desc)
    render("posts/index")
  end

  def asc
    @posts = Post.all.order(created_at: :asc)
    render("posts/index")
  end

end
