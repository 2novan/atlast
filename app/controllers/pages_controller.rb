class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # redirect_to newsfeed_path if user_signed_in?
    @disable_nav = true
    @disable_footer = true
  end

  def welcome
    # @artistscount = @spotify_user.artists
    @skip_footer = true
    @artists = Artist.all
    @followed_artist = current_user.followed_artists.find_by(artist: @artist)
  end

  def components
    @artists = Artist.all
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Artist.where("name ILIKE ?", "%#{params[:search]}%").first(5)
      # @results = Artist.where("name ILIKE ?", "%#{@parameter}%").first(5)
      @results_number = RSpotify::Artist.search("%#{@parameter}%").count
      
      # @results.each do |spotify_artist|
      #   artist = Artist.where({name: spotify_artist.name, spotify_id: spotify_artist.id, image_url: spotify_artist.images.last&.fetch("url") }).first_or_create
      #   spotify_artist.genres.each do |genre|
      #     genre = Genre.where({name: genre}).first_or_create
      #     artist_genre = ArtistGenre.where({genre: genre, artist: artist}).first_or_create
      #   end
      #   spotify_artist.albums.each do |release|
      #     sleep 0.05
      #     release_date = release.release_date =~ /\d{4}-\d{2}-\d{2}/ ? release.release_date : Date.new(release.release_date.to_i, 1, 1)
      #     album = Release.where({name: release.name, album_type: release.album_type, artist_id: artist, image_url: release.images.last["url"], total_tracks: release.total_tracks, artist_id: artist, release_date: release_date, spotify_id: release.id}).first_or_create
      #     release.tracks.each do |track|
      #       sleep 0.05
      #       track = Track.where({name: track.name, duration: track.duration_ms, track_number: track.track_number, spotify_id: track.id, release: album}).first_or_create!
      #       track_artist = TrackArtist.where({track_id: track, artist_id: artist}).first_or_create!
      #     end
      #   end
      # end
    end
  end
end
