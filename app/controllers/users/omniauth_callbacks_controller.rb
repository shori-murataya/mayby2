class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :omniauth_set

  def facebook
    sign_in_with_provider(action_name, "Facebook")
  end

  def twitter
    sign_in_with_provider(action_name, "Twitter")
  end

  def google_oauth2
    sign_in_with_provider(action_name, "Google")
  end

  def failure
    redirect_to root_path
  end

  private
  def omniauth_set
    @user = User.first_or_create_from_omniauth(request.env["omniauth.auth"])
  end

  def sign_in_with_provider(provider, provider_name)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: provider_name) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      render 'devise/registrations/new'
    end
  end
end