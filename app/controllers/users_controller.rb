class UsersController < ApplicationController
  def index
    @users = User.all
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


end
