class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]
  has_many :followed_artists
  has_many :artists, through: :followed_artists

  def self.find_for_spotify_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params[:email] = auth.info.email
    user_params[:avatar_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:nickname] = auth.info.name
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
      Spotify::FetchArtists.new(user).call
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20]  # Fake password for validation
      user.save
      Spotify::FetchArtists.new(user).call
    end

    return user
  end
end
