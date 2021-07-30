RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # redirect_to newsfeed_path if user_signed_in?
    @disable_nav = true
    @disable_footer = true
  end

  def welcome
    # @artistscount = @spotify_user.artists
    @disable_footer = true
    @followed_artists = current_user.followed_artists.includes(:artist)
    @recommendations = Spotify::FetchRecommendations.new(current_user).call
  end

  def components
    @artists = Artist.all
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      query = params[:search].downcase
      @artists = Spotify::SearchArtists.new(query).call
      @results_number = @artists.length
    end
  end
end
