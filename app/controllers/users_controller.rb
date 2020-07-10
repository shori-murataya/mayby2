class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
    @user = User.new(
      name:params[:name],
      email:params[:email],
      password:params[:pass])
    if @user.save
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
