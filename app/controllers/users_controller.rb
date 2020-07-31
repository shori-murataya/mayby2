class UsersController < ApplicationController
  before_action :access_right_user,{only:[:edit]}
  before_action :login_user,{only:[:new]}
  

  def access_right_user
    @user = User.find_by(id: params[:id])
    if @user.id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end
  def login_user
    if @current_user
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end

  def index
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    @users = @q.result
  end

  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: params[:id])
    @comments = Comment.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name:params[:name],
      email:params[:email],
      password:params[:pass],
      image_name:"default_image.jpg")
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/index")
    else
      render("users/new")
    end
  end

  def destroy
    @user = User.find_by(id:params[:id])
    @user.destroy
    redirect_to("/users/index")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
    @user.image_name = "#{@user.id}.jpg"
    image = params[:image]
    File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    if @user.save
    flash[:notice] = "編集完了"
    redirect_to("/users/index")
    else
    flash[:notice] = "編集失敗"
    render("users/edit")
    end
  end

  def edit_pass
    @user = User.find(params[:id])
  end
  def update_pass
    @user = User.find_by(id: params[:id])
    if @user.authenticate(params[:pass])
      @user.password = params[:new_pass]
      @user.save
      flash[:notice] = "変更しました"
      redirect_to("/users/index")
    else
      flash[:notice] = "変更できませんでした"
      render("users/edit_pass")
    end
  end

  def login
  end
  
  def in
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:pass])
        session[:user_id] = @user.id
        flash[:notice] = "ログインしました"
        redirect_to("/users/index")
      else
        flash[:notice] = "ログイン失敗"        
        render("users/login")
      end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
  
end
