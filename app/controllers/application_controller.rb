class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      repost user_spotify_omniauth_authorize_path, options: { authenticity_token: :auto }
    end
  end
end
