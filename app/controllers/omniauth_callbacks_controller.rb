class OmniauthCallbacksController < ApplicationController
  def wordpress_oauth2

    #You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_wordpress_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Wordpress Oauth2") if is_navigational_format?
    else
      session["devise.mca_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
