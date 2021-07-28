class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def spotify
    user, sign_up = User.find_for_spotify_oauth(request.env['omniauth.auth'])

    if user.persisted?
      set_flash_message(:notice, :success, kind: 'spotify') if is_navigational_format?
      if sign_up
        sign_in user
        redirect_to welcome_path
      else
        sign_in_and_redirect user, event: :authentication
      end
    else
      session['devise.spotify_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
