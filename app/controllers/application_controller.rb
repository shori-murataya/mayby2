class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :no_login_user,{ only:[:index, :show, :edit] }

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def no_login_user
    if @current_user == nil
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
