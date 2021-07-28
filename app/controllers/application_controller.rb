class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  def authenticate_user!
    if user_signed_in? 
      super
    else
      repost user_spotify_omniauth_authorize_path, options: { authenticity_token: :auto }
    end
  end
end
