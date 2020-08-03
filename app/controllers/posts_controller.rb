class PostsController < ApplicationController

  def show
    @post = Post.find_by(id: params[:id])
    @posts = Post.where(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @comment = Comment.new
    @comments = Comment.where(post_id: params[:id]).page(params[:page]).per(2).order(created_at: :desc)
    @likes = Like.where(post_id: params[:id]).order(created_at: :desc).limit(1)
    @like = Like.where(post_id:params[:id])
  end 

  def index
    @q = Post.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @posts = @q.result.page(params[:page]).per(2).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:title],
      howto: params[:howto],
      user_id: current_user.id,
      num_of_people: params[:num_of_people],
      play_style: params[:play_style]
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
    @post.title = params[:title]
    @post.howto = params[:howto]
    @post.num_of_people = params[:num_of_people]
    @post.play_style = params[:play_style]
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



end
