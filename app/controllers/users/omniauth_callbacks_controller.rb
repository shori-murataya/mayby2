class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :omniauth_set

  def facebook
    sign_in_with_provider(action_name)
  end

  def twitter
    sign_in_with_provider(action_name)
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # if @user.persisted?
    #   sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    # else
    #   session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
    #   render 'devise/registrations/new'
    # end
    sign_in_with_provider(action_name)
  end

  def failure
    redirect_to root_path
  end

  private
  def omniauth_set
    @user = User.first_or_create_from_omniauth(request.env["omniauth.auth"])
  end

  def sign_in_with_provider(provider)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{provider.capitalize}") if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      render 'devise/registrations/new'
    end
  end

end